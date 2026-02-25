import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/constants/app_durations.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/game/application/providers/game_providers.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_action_bar.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_board.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_result_overlay.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_status_bar.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_top_bar.dart';
import 'package:tic_tac_bet/core/entities/game_outcome.dart';
import 'package:tic_tac_bet/features/history/application/providers/history_providers.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key, required this.mode});

  final GameMode mode;

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  int? _coinsDelta;
  bool _isResolvingBet = false;
  bool _showResultOverlay = false;
  int _overlaySequence = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameControllerProvider.notifier).startGame(widget.mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameControllerProvider);

    ref.listen(gameControllerProvider, (prev, next) {
      if (prev?.isGameOver == false && next.isGameOver) {
        _scheduleResultOverlay(next.result);
        _handleGameFinished(next);
      }
    });

    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleSystemBackIntent();
      },
      child: Scaffold(
        body: AppPatternBackground(
          child: Column(
            children: [
              GameTopBar(mode: gameState.mode),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppDimensions.spacingM,
                          AppDimensions.spacingS,
                          AppDimensions.spacingM,
                          AppDimensions.spacingM,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: AppDimensions.spacingS),
                            GameStatusBar(
                              currentPlayer: gameState.currentPlayer,
                              isAiThinking: gameState.isAiThinking,
                              mode: gameState.mode,
                              onlineOpponentName: ref
                                  .read(gameControllerProvider.notifier)
                                  .opponentName,
                            ),
                            const SizedBox(height: AppDimensions.spacingM),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: GameBoard(
                                    board: gameState.board,
                                    result: gameState.result,
                                    onCellTap: (row, col) => ref
                                        .read(gameControllerProvider.notifier)
                                        .playMove(row, col),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spacingM),
                            GameActionBar(
                              mode: gameState.mode,
                              onRestart: _resetGame,
                              onQuit: _handleBack,
                            ),
                          ],
                        ),
                      ),
                      if (gameState.isGameOver && _showResultOverlay)
                        GameResultOverlay(
                          result: gameState.result,
                          mode: gameState.mode,
                          coinsDelta: _coinsDelta,
                          isResolvingBet: _isResolvingBet,
                          onPlayAgain: _resetGame,
                          onBackToHome: () => context.goNamed(AppRouter.home),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSystemBackIntent() async {
    final state = ref.read(gameControllerProvider);
    final isRankedOngoing = state.mode is GameModeOnline && !state.isGameOver;
    if (!isRankedOngoing) {
      _handleBack();
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(dialogContext.l10n.abandonMatchTitle),
          content: Text(dialogContext.l10n.abandonMatchMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(dialogContext.l10n.cancelMatch),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(dialogContext.l10n.abandon),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      _handleBack();
    }
  }

  void _handleBack() {
    _clearPendingOnlineBetIfNeeded();
    context.pop();
  }

  void _resetGame() {
    setState(() {
      _coinsDelta = null;
      _isResolvingBet = false;
      _showResultOverlay = false;
    });
    ref.read(gameControllerProvider.notifier).reset();
  }

  void _scheduleResultOverlay(GameResult result) {
    final sequence = ++_overlaySequence;
    setState(() => _showResultOverlay = false);

    final delay = result is GameResultWin
        ? AppDurations.victoryLine + AppDurations.instant
        : Duration.zero;

    if (delay == Duration.zero) {
      if (mounted && sequence == _overlaySequence) {
        setState(() => _showResultOverlay = true);
      }
      return;
    }

    Future<void>.delayed(delay, () {
      if (!mounted || sequence != _overlaySequence) return;
      setState(() => _showResultOverlay = true);
    });
  }

  Future<void> _handleGameFinished(GameState gameState) async {
    if (!mounted) return;

    final currentBet = ref.read(currentBetProvider);
    int? coinsWon;
    int? betAmount;

    if (gameState.mode is GameModeOnline && currentBet != null) {
      setState(() => _isResolvingBet = true);

      final outcome = _outcomeFromResult(gameState.result);
      final resolution = await ref
          .read(bettingServiceProvider)
          .resolve(currentBet, outcome);
      betAmount = currentBet.amount;

      final coinsDelta = switch (outcome) {
        GameOutcome.win => resolution?.balanceChange ?? 0,
        GameOutcome.loss => -currentBet.amount,
        GameOutcome.draw => null,
      };

      if (outcome == GameOutcome.win) coinsWon = resolution?.balanceChange;

      ref.read(currentBetProvider.notifier).clear();

      if (mounted) {
        setState(() {
          _isResolvingBet = false;
          _coinsDelta = coinsDelta;
        });
      }
    }

    await ref.read(saveGameResultUseCaseProvider)(
      mode: gameState.mode,
      outcome: _outcomeFromResult(gameState.result),
      playerSide: Player.x,
      moves: gameState.moves,
      betAmount: betAmount,
      coinsWon: coinsWon,
    );

    if (mounted) {
      ref.invalidate(historyProvider);
      ref.invalidate(statisticsProvider);
    }
  }

  GameOutcome _outcomeFromResult(GameResult result) {
    return switch (result) {
      GameResultDraw() => GameOutcome.draw,
      GameResultWin(:final winner) =>
        winner == Player.x ? GameOutcome.win : GameOutcome.loss,
      GameResultOngoing() => GameOutcome.draw,
    };
  }

  void _clearPendingOnlineBetIfNeeded() {
    final state = ref.read(gameControllerProvider);
    if (state.mode is! GameModeOnline || state.isGameOver) return;
    if (ref.read(currentBetProvider) == null) return;
    ref.read(currentBetProvider.notifier).clear();
  }
}
