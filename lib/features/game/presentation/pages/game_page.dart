import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/resolve_bet.dart';
import 'package:tic_tac_bet/features/game/application/providers/game_providers.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/history/application/providers/history_providers.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_action_bar.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_board.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_result_overlay.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_status_bar.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key, required this.mode});

  final GameMode mode;

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  bool _gameResultHandled = false;

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

    if (gameState.isGameOver && !_gameResultHandled) {
      _gameResultHandled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleGameFinished(gameState);
      });
    } else if (!gameState.isGameOver && _gameResultHandled) {
      _gameResultHandled = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _clearPendingOnlineBetIfNeeded();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: AppPatternBackground(
          child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingM),
              child: Column(
                children: [
                  GameStatusBar(
                    currentPlayer: gameState.currentPlayer,
                    isAiThinking: gameState.isAiThinking,
                    mode: gameState.mode,
                  ),
                  const Spacer(),
                  GameBoard(
                    board: gameState.board,
                    result: gameState.result,
                    onCellTap: (row, col) {
                      ref
                          .read(gameControllerProvider.notifier)
                          .playMove(row, col);
                    },
                  ),
                  const Spacer(),
                  GameActionBar(
                    onRestart: () {
                      _clearPendingOnlineBetIfNeeded();
                      ref.read(gameControllerProvider.notifier).reset();
                    },
                    onQuit: () {
                      _clearPendingOnlineBetIfNeeded();
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
            if (gameState.isGameOver)
              GameResultOverlay(
                result: gameState.result,
                mode: gameState.mode,
                onPlayAgain: () {
                  _clearPendingOnlineBetIfNeeded();
                  ref.read(gameControllerProvider.notifier).reset();
                },
                onBackToHome: () => context.go('/'),
              ),
          ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGameFinished(GameState gameState) async {
    if (!mounted) return;

    final currentBet = ref.read(currentBetProvider);
    BetResolution? resolution;
    int? coinsWon;
    int? betAmount;

    if (gameState.mode is GameModeOnline && currentBet != null) {
      final outcome = _onlineOutcomeFromResult(gameState.result);
      resolution = await ref.read(bettingServiceProvider).resolve(
        currentBet,
        outcome,
      );
      betAmount = currentBet.amount;
      if (outcome == GameOutcome.win) {
        coinsWon = resolution?.balanceChange ?? 0;
      }
      ref.read(currentBetProvider.notifier).clear();
    }

    final entry = GameHistoryEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      playedAt: DateTime.now(),
      mode: gameState.mode,
      outcome: _historyOutcomeFromGameResult(gameState.result, gameState.mode),
      playerSide: Player.x,
      moves: gameState.moves,
      betAmount: betAmount,
      coinsWon: coinsWon,
    );

    await ref.read(historyRepositoryProvider).addEntry(entry);

    if (mounted) {
      ref.invalidate(historyProvider);
      ref.invalidate(statisticsProvider);
      ref.invalidate(onlineStatisticsProvider);
    }
  }

  GameOutcome _historyOutcomeFromGameResult(GameResult result, GameMode mode) {
    return switch (result) {
      GameResultDraw() => GameOutcome.draw,
      GameResultWin(:final winner) when mode is GameModeVsAi =>
        winner == Player.x ? GameOutcome.win : GameOutcome.loss,
      GameResultWin(:final winner) => winner == Player.x
          ? GameOutcome.win
          : GameOutcome.loss,
      GameResultOngoing() => GameOutcome.draw,
    };
  }

  GameOutcome _onlineOutcomeFromResult(GameResult result) {
    return switch (result) {
      GameResultDraw() => GameOutcome.draw,
      GameResultWin(:final winner) => winner == Player.x
          ? GameOutcome.win
          : GameOutcome.loss,
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
