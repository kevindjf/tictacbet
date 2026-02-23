import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/move.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/tutorial_board_grid.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/tutorial_victory_reward.dart';
import 'package:tic_tac_bet/features/onboarding/presentation/widgets/coach_text_card.dart';

/// Interactive tutorial that guides the user through a pre-scripted winning
/// game using [TutorialCoachMark] spotlights, then celebrates with the
/// [TutorialVictoryReward] screen and awards 1 000 starting coins.
///
/// Game sequence (X always wins the top row):
///   1. X → (0,0)  — player tap
///   2. O → (1,1)  — AI auto-play
///   3. X → (0,1)  — player tap
///   4. O → (2,0)  — AI auto-play
///   5. X → (0,2)  — player tap → WIN
class TutorialGameSimulation extends StatefulWidget {
  const TutorialGameSimulation({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<TutorialGameSimulation> createState() => _TutorialGameSimulationState();
}

class _TutorialGameSimulationState extends State<TutorialGameSimulation> {
  Board _board = Board.empty();
  GameResult _result = const GameResult.ongoing();
  bool _showVictory = false;

  /// Row-major order: index = row * 3 + col.
  final List<GlobalKey> _cellKeys = List.generate(9, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchCoachMark());
  }

  // ── Board helpers ─────────────────────────────────────────────────────────

  void _placeX(int row, int col) {
    if (!mounted) return;
    setState(() {
      _board = _board.applyMove(Move(row: row, col: col, player: Player.x));
    });
  }

  void _placeO(int row, int col) {
    if (!mounted) return;
    setState(() {
      _board = _board.applyMove(Move(row: row, col: col, player: Player.o));
    });
  }

  // ── Coach mark ────────────────────────────────────────────────────────────

  void _launchCoachMark() {
    if (!mounted) return;

    final theme = Theme.of(context);

    TutorialCoachMark(
      targets: _coachTargets(theme),
      colorShadow: theme.colorScheme.scrim,
      opacityShadow: 0.72,
      paddingFocus: AppDimensions.spacingS,
      textSkip: context.l10n.skip,
      onClickTarget: (target) {
        switch (target.identify) {
          case 'move1':
            _placeX(0, 0);
            Future.delayed(
              const Duration(milliseconds: 650),
              () => _placeO(1, 1),
            );
          case 'move2':
            _placeX(0, 1);
            Future.delayed(
              const Duration(milliseconds: 650),
              () => _placeO(2, 0),
            );
          case 'move3':
            _placeX(0, 2);
        }
      },
      onFinish: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          setState(() {
            _result = const GameResult.win(
              winner: Player.x,
              winningLine: [(0, 0), (0, 1), (0, 2)],
            );
          });
          Future.delayed(const Duration(milliseconds: 1400), () {
            if (!mounted) return;
            setState(() => _showVictory = true);
          });
        });
      },
      onSkip: () {
        if (mounted) setState(() => _showVictory = true);
        return true;
      },
    ).show(context: context);
  }

  List<TargetFocus> _coachTargets(ThemeData theme) {
    final betclic = theme.extension<BetclicTheme>()!;
    final overlayTextColor = betclic.coachTextColor;
    final textStyle = theme.textTheme.bodyMedium!.copyWith(
      color: overlayTextColor,
      height: 1.25,
      shadows: [Shadow(color: betclic.coachTextShadowColor, blurRadius: 8)],
    );
    final titleStyle = theme.textTheme.titleMedium!.copyWith(
      color: overlayTextColor,
      fontWeight: FontWeight.bold,
      shadows: [Shadow(color: betclic.coachTextShadowColor, blurRadius: 10)],
    );

    return [
      _targetFocus(
        id: 'move1',
        keyTarget: _cellKeys[0],
        title: context.l10n.tutorialHint1Title,
        body: context.l10n.tutorialHint1Body,
        titleStyle: titleStyle,
        bodyStyle: textStyle,
      ),
      _targetFocus(
        id: 'move2',
        keyTarget: _cellKeys[1],
        title: context.l10n.tutorialHint2Title,
        body: context.l10n.tutorialHint2Body,
        titleStyle: titleStyle,
        bodyStyle: textStyle,
      ),
      _targetFocus(
        id: 'move3',
        keyTarget: _cellKeys[2],
        title: context.l10n.tutorialHint3Title,
        body: context.l10n.tutorialHint3Body,
        titleStyle: titleStyle,
        bodyStyle: textStyle,
      ),
    ];
  }

  TargetFocus _targetFocus({
    required String id,
    required GlobalKey keyTarget,
    required String title,
    required String body,
    required TextStyle titleStyle,
    required TextStyle bodyStyle,
  }) {
    return TargetFocus(
      identify: id,
      keyTarget: keyTarget,
      shape: ShapeLightFocus.RRect,
      radius: AppDimensions.radiusM,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.spacingL),
            child: CoachTextCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle),
                  const SizedBox(height: AppDimensions.spacingS),
                  Text(body, style: bodyStyle),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AppPatternBackground(
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: AppDimensions.spacingXL),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingM,
                  ),
                  child:
                      Text(
                        context.l10n.tutorialSimulationTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(
                        duration: const Duration(milliseconds: 400),
                      ),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingM,
                  ),
                  child:
                      Text(
                        context.l10n.tutorialSimulationSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(
                        duration: const Duration(milliseconds: 500),
                      ),
                ),
                const Spacer(),
                Center(
                  child: TutorialBoardGrid(
                    board: _board,
                    result: _result,
                    cellKeys: _cellKeys,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          if (_showVictory)
            TutorialVictoryReward(
              onComplete: widget.onComplete,
            ).animate().fadeIn(duration: const Duration(milliseconds: 300)),
        ],
      ),
    );
  }
}
