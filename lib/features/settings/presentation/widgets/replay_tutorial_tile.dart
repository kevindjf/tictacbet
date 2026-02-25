import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';

/// Settings item that replays the onboarding tutorial.
class ReplayTutorialTile extends ConsumerWidget {
  /// Creates the replay tutorial settings item.
  const ReplayTutorialTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        key: const Key('replay_tutorial_settings_tile'),
        leading: const Icon(Icons.school),
        title: Text(context.l10n.replayTutorial),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onReplayTutorialTap(context, ref),
      ),
    );
  }

  Future<void> _onReplayTutorialTap(BuildContext context, WidgetRef ref) async {
    await ref.read(onboardingControllerProvider.notifier).reset();
    if (!context.mounted) return;
    context.pushNamed(AppRouter.onboarding);
  }
}
