import 'package:flutter/material.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';
import 'package:tic_tac_bet/features/history/presentation/widgets/history_tile.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.entries});

  final List<GameHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (final entry in entries) HistoryTile(entry: entry)],
    );
  }
}
