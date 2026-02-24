import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/extensions/betclic_theme_context_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

/// Animated coin gain/loss section displayed in the end-game overlay for
/// ranked (online) matches. Shows a loading state while the bet is being
/// resolved, then animates the coin counter once the result is known.
class GameCoinResultSection extends StatefulWidget {
  const GameCoinResultSection({
    super.key,
    required this.coinsDelta,
    this.isLoading = false,
  });

  /// Net coin change for the player. Positive = gain, negative = loss.
  final int coinsDelta;

  /// Whether the bet resolution is still in progress.
  final bool isLoading;

  @override
  State<GameCoinResultSection> createState() => _GameCoinResultSectionState();
}

class _GameCoinResultSectionState extends State<GameCoinResultSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<int> _countAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _buildAnimation();
    if (!widget.isLoading) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(GameCoinResultSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading && !widget.isLoading) {
      _buildAnimation();
      _controller
        ..reset()
        ..forward();
    }
  }

  void _buildAnimation() {
    _countAnimation = IntTween(
      begin: 0,
      end: widget.coinsDelta.abs(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        height: AppDimensions.iconL,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final betclic = context.betclic;
    final isGain = widget.coinsDelta > 0;
    final coinColor = isGain ? betclic.coinColor : Colors.redAccent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.monetization_on, size: AppDimensions.iconL, color: coinColor)
            .animate()
            .scale(
              begin: const Offset(0, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.elasticOut,
            )
            .fadeIn(),
        const SizedBox(height: AppDimensions.spacingS),
        AnimatedBuilder(
          animation: _countAnimation,
          builder: (context, _) {
            final label = isGain
                ? context.l10n.coinsWon(_countAnimation.value)
                : context.l10n.coinsLost(_countAnimation.value);
            return Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: coinColor,
                fontWeight: FontWeight.w900,
              ),
            );
          },
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }
}
