import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/history/application/providers/history_providers.dart';
import 'package:tic_tac_bet/features/history/presentation/widgets/history_list.dart';
import 'package:tic_tac_bet/features/history/presentation/widgets/statistics_card.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    final statsAsync = ref.watch(statisticsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.history)),
      body: historyAsync.when(
        data: (entries) => ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          children: [
            statsAsync.when(
              data: (stats) => StatisticsCard(statistics: stats),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            if (entries.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacingXL),
                  child: Text(
                    context.l10n.noGamesYet,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              HistoryList(entries: entries),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }
}
