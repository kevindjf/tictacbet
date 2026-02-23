import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/theme/betclic_theme_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/board.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_result.dart';
import 'package:tic_tac_bet/features/game/domain/entities/player.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/game_cell.dart';
import 'package:tic_tac_bet/features/game/presentation/widgets/victory_line_painter.dart';

/// Like [GameBoard] but exposes [cellKeys] so [tutorial_coach_mark] can
/// spotlight individual cells.
class TutorialBoardGrid extends StatelessWidget {
  const TutorialBoardGrid({
    super.key,
    required this.board,
    required this.result,
    required this.cellKeys,
  });

  final Board board;
  final GameResult result;

  /// 9 GlobalKeys, one per cell in row-major order.
  final List<GlobalKey> cellKeys;

  @override
  Widget build(BuildContext context) {
    final betclic = Theme.of(context).extension<BetclicTheme>()!;

    final winResult = switch (result) {
      final GameResultWin win => win,
      _ => null,
    };
    final winningLine = winResult?.winningLine;
    final winnerColor = winResult != null
        ? (winResult.winner == Player.x
              ? betclic.playerXColor
              : betclic.playerOColor)
        : betclic.playerXColor;

    return SizedBox(
      width: AppDimensions.boardSize,
      height: AppDimensions.boardSize,
      child: Stack(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppDimensions.cellSpacing,
              mainAxisSpacing: AppDimensions.cellSpacing,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final col = index % 3;
              final player = board.cellAt(row, col);
              final isWinningCell =
                  winningLine?.any((pos) => pos.$1 == row && pos.$2 == col) ??
                  false;

              return Container(
                key: cellKeys[index],
                child: GameCell(
                  player: player,
                  isWinningCell: isWinningCell,
                  onTap: () {},
                ),
              );
            },
          ),
          if (winningLine != null)
            Positioned.fill(
              child: CustomPaint(
                painter: VictoryLinePainter(
                  line: winningLine,
                  color: winnerColor,
                  boardSize: AppDimensions.boardSize,
                ),
              ).animate().fadeIn(duration: 400.ms),
            ),
        ],
      ),
    );
  }
}
