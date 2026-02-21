import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/app_logo.dart';
import 'package:tic_tac_bet/features/home/presentation/widgets/mode_card.dart';
import 'package:tic_tac_bet/features/settings/application/providers/settings_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(difficultyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('history'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed('settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          child: Column(
            children: [
              const Spacer(),
              const AppLogo(),
              const SizedBox(height: AppDimensions.spacingXL),
              Text(
                context.l10n.selectMode,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppDimensions.spacingL),
              ModeCard(
                icon: Icons.smart_toy,
                title: context.l10n.vsAi,
                subtitle: context.l10n.trainingDescription,
                onTap: () => context.pushNamed(
                  'game',
                  extra: GameMode.vsAi(difficulty: difficulty),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              ModeCard(
                icon: Icons.people,
                title: context.l10n.vsLocal,
                subtitle: context.l10n.trainingDescription,
                onTap: () =>
                    context.pushNamed('game', extra: const GameMode.vsLocal()),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              ModeCard(
                icon: Icons.emoji_events,
                title: context.l10n.competition,
                subtitle: context.l10n.competitionDescription,
                onTap: () => context.pushNamed('bet'),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
