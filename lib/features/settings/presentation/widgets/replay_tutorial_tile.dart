import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/onboarding/application/providers/onboarding_providers.dart';

class ReplayTutorialTile extends ConsumerWidget {
  const ReplayTutorialTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.school),
        title: Text(context.l10n.replayTutorial),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ref.read(onboardingNotifierProvider.notifier).reset();
          context.pushNamed('onboarding');
        },
      ),
    );
  }
}
