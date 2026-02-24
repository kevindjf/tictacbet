import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
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

  int _minimumBet() => forMatchmaking ? 1 : Wallet.minimumBet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minimumBet = _minimumBet();
    final wallet = ref.watch(walletControllerProvider);
    final rawBetAmount = ref.watch(betPlacementAmountProvider(forMatchmaking));
    final canPlaceBet = wallet.availableBalance >= minimumBet;
    final clampedBetAmount = wallet.availableBalance < minimumBet
        ? minimumBet
        : rawBetAmount.clamp(minimumBet, wallet.availableBalance);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.placeBet)),
      body: SafeArea(
        child: AppPatternBackground(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            child: _BetPlacementBody(
              wallet: wallet,
              minimumBet: minimumBet,
              canPlaceBet: canPlaceBet,
              clampedBetAmount: clampedBetAmount,
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
    required this.wallet,
    required this.minimumBet,
    required this.canPlaceBet,
    required this.clampedBetAmount,
    required this.forMatchmaking,
  });

  final Wallet wallet;
  final int minimumBet;
  final bool canPlaceBet;
  final int clampedBetAmount;
  final bool forMatchmaking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CoinBalance(balance: wallet.balance),
        const Spacer(),
        BetSlider(
          currentBet: clampedBetAmount,
          maxBet: wallet.availableBalance,
          minimumBet: minimumBet,
          multiplier: 1.0,
          onChanged: (value) =>
              ref
                      .read(betPlacementAmountProvider(forMatchmaking).notifier)
                      .state =
                  value,
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                canPlaceBet && clampedBetAmount <= wallet.availableBalance
                ? () => _submitBetAndMaybeNavigate(
                    ref,
                    context,
                    forMatchmaking: forMatchmaking,
                    betAmount: clampedBetAmount,
                    minimumBet: minimumBet,
                  )
                : null,
            child: Text(context.l10n.betAmount(clampedBetAmount)),
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
  required int minimumBet,
}) async {
  final bet = await ref
      .read(bettingServiceProvider)
      .place(betAmount, minimumBet: minimumBet);

  if (bet == null || !context.mounted) return;

  ref.read(currentBetProvider.notifier).setBet(bet);

  if (forMatchmaking) {
    await ref.read(matchmakingRepositoryProvider).createProposal(betAmount);
    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.waitingForOpponent)));
    context.goNamed('lobby');
    return;
  }

  context.pushNamed('game', extra: const GameMode.online());
}
