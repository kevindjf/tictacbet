import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/constants/app_durations.dart';
import 'package:tic_tac_bet/core/widgets/grid_pattern_painter.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/game_mode_card_play_button.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/game_mode_card_tag.dart';

class GameModeCard extends StatefulWidget {
  const GameModeCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.accentColor,
    required this.onTap,
    this.tag,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final Color accentColor;
  final VoidCallback onTap;
  final String? tag;

  @override
  State<GameModeCard> createState() => _GameModeCardState();
}

class _GameModeCardState extends State<GameModeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            widget.onTap();
          },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.95 : 1.0,
            duration: AppDurations.fast,
            child: Container(
              width: screenWidth * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimensions.gameCardBorderRadius,
                ),
                border: Border.all(
                  color: widget.accentColor.withAlpha(80),
                  width: 1,
                ),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withAlpha(60),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GridPatternPainter(
                        lineColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingL),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.tag != null) ...[
                          GameModeCardTag(
                            tag: widget.tag!,
                            color: widget.accentColor,
                          ),
                          const SizedBox(height: AppDimensions.spacingM),
                        ],
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                height: 0.95,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        const SizedBox(height: AppDimensions.spacingS),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: AppDimensions.spacingL),
                        GameModeCardPlayButton(
                          label: widget.buttonLabel,
                          color: widget.accentColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: AppDurations.slower.inMilliseconds.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          duration: AppDurations.slower.inMilliseconds.ms,
          curve: Curves.easeOut,
        );
  }
}
