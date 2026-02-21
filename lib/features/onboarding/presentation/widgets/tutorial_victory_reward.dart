import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class TutorialVictoryReward extends StatefulWidget {
  const TutorialVictoryReward({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<TutorialVictoryReward> createState() => _TutorialVictoryRewardState();
}

class _TutorialVictoryRewardState extends State<TutorialVictoryReward>
    with SingleTickerProviderStateMixin {
  late final AnimationController _coinController;
  late final Animation<int> _coinAnimation;

  @override
  void initState() {
    super.initState();
    _coinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _coinAnimation = IntTween(begin: 0, end: 1000).animate(
      CurvedAnimation(parent: _coinController, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _coinController.forward();
    });
  }

  @override
  void dispose() {
    _coinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(Icons.emoji_events, size: 100, color: betclic.coinColor)
                  .animate()
                  .scale(
                    begin: const Offset(0, 0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                  ),
              const SizedBox(height: AppDimensions.spacingL),
              Text(
                context.l10n.tutorialVictoryTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: betclic.playerXColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 400),
              ),
              const SizedBox(height: AppDimensions.spacingXL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingS,
                    ),
                    child: Icon(
                      Icons.monetization_on,
                      size: 32,
                      color: betclic.coinColor,
                    )
                        .animate(delay: Duration(milliseconds: i * 100))
                        .slideY(
                          begin: -1.5,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                        )
                        .fadeIn(),
                  ),
                ),
              ).animate().fadeIn(
                delay: const Duration(milliseconds: 400),
              ),
              const SizedBox(height: AppDimensions.spacingL),
              AnimatedBuilder(
                animation: _coinAnimation,
                builder: (context, _) {
                  return Text(
                    context.l10n.tutorialRewardCoins(_coinAnimation.value),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: betclic.coinColor,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppDimensions.spacingS),
              Text(
                context.l10n.tutorialRewardSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 400),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onComplete,
                  child: Text(context.l10n.tutorialStartPlaying),
                ),
              )
                  .animate()
                  .slideY(
                    begin: 0.4,
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                  )
                  .fadeIn(delay: const Duration(milliseconds: 1000)),
            ],
          ),
        ),
      ),
    );
  }
}
