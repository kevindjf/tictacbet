import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/router/app_router.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/core/widgets/app_pattern_background.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/bet_slider.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/coin_balance.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/matchmaking/application/providers/matchmaking_providers.dart';

class BetPlacementPage extends ConsumerWidget {
  const BetPlacementPage({super.key, this.forMatchmaking = false});

  final bool forMatchmaking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(betPlacementViewModelProvider(forMatchmaking));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.placeBet)),
      body: SafeArea(
        child: AppPatternBackground(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            child: _BetPlacementBody(
              vm: vm,
              forMatchmaking: forMatchmaking,
            ),
          ),
        ),
      ),
    );
  }
}

class _BetPlacementBody extends ConsumerWidget {
  const _BetPlacementBody({
    required this.vm,
    required this.forMatchmaking,
  });

  final BetPlacementViewModel vm;
  final bool forMatchmaking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CoinBalance(balance: vm.wallet.balance),
        const Spacer(),
        BetSlider(
          currentBet: vm.clampedAmount,
          maxBet: vm.wallet.availableBalance,
          minimumBet: Wallet.minimumBet,
          potentialWinnings: vm.potentialWinnings,
          enabled: vm.canPlace,
          onChanged: (value) =>
              ref.read(betPlacementAmountProvider(forMatchmaking).notifier).state = value,
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: vm.canPlace
                ? () => _submitBetAndMaybeNavigate(
                      ref,
                      context,
                      forMatchmaking: forMatchmaking,
                      betAmount: vm.clampedAmount,
                    )
                : null,
            child: Text(context.l10n.betAmount(vm.clampedAmount)),
          ),
        ),
      ],
    );
  }
}

Future<void> _submitBetAndMaybeNavigate(
  WidgetRef ref,
  BuildContext context, {
  required bool forMatchmaking,
  required int betAmount,
}) async {
  final bet = await ref
      .read(bettingServiceProvider)
      .place(betAmount);

  if (bet == null || !context.mounted) return;

  ref.read(currentBetProvider.notifier).setBet(bet);

  if (forMatchmaking) {
    await ref.read(matchmakingRepositoryProvider).createProposal(betAmount);
    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.waitingForOpponent)));
    context.goNamed(AppRouter.lobby);
    return;
  }

  context.pushNamed(AppRouter.game, extra: const GameMode.online());
}
