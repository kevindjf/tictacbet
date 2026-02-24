import 'package:flutter/material.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/presentation/widgets/history_tile.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.entries});

  final List<GameHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return HistoryTile(entry: entries[index]);
      },
    );
  }
}
