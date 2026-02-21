import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/application/providers/game_providers.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameNotifierProvider.notifier).startGame(widget.mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
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
                          .read(gameNotifierProvider.notifier)
                          .playMove(row, col);
                    },
                  ),
                  const Spacer(),
                  GameActionBar(
                    onRestart: () {
                      ref.read(gameNotifierProvider.notifier).reset();
                    },
                    onQuit: () => context.pop(),
                  ),
                ],
              ),
            ),
            if (gameState.isGameOver)
              GameResultOverlay(
                result: gameState.result,
                mode: gameState.mode,
                onPlayAgain: () {
                  ref.read(gameNotifierProvider.notifier).reset();
                },
                onBackToHome: () => context.go('/'),
              ),
          ],
        ),
      ),
    );
  }
}
