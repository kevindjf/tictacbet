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
import 'package:tic_tac_bet/features/betting/presentation/widgets/streak_display.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';
import 'package:tic_tac_bet/features/matchmaking/application/providers/matchmaking_providers.dart';

class BetPlacementPage extends ConsumerStatefulWidget {
  const BetPlacementPage({
    super.key,
    this.forMatchmaking = false,
  });

  final bool forMatchmaking;

  @override
  ConsumerState<BetPlacementPage> createState() => _BetPlacementPageState();
}

class _BetPlacementPageState extends ConsumerState<BetPlacementPage> {
  int _betAmount = Wallet.minimumBet;

  int _clampBetAmount(int maxAvailable) {
    if (maxAvailable < Wallet.minimumBet) return Wallet.minimumBet;
    return _betAmount.clamp(Wallet.minimumBet, maxAvailable);
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletControllerProvider);
    final streak = ref.watch(streakControllerProvider);
    final canPlaceBet = wallet.availableBalance >= Wallet.minimumBet;
    final clampedBetAmount = _clampBetAmount(wallet.availableBalance);

    if (_betAmount != clampedBetAmount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _betAmount = clampedBetAmount);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.placeBet)),
      body: SafeArea(
        child: AppPatternBackground(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingM),
            child: Column(
              children: [
                CoinBalance(balance: wallet.balance),
                const SizedBox(height: AppDimensions.spacingL),
                StreakDisplay(streak: streak),
                const Spacer(),
                BetSlider(
                  currentBet: clampedBetAmount,
                  maxBet: wallet.availableBalance,
                  multiplier: streak.multiplier,
                  onChanged: (value) {
                    setState(() => _betAmount = value);
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: canPlaceBet && wallet.canBet(clampedBetAmount)
                        ? () async {
                            final bet = await ref
                                .read(bettingServiceProvider)
                                .place(clampedBetAmount);
                            if (bet != null && context.mounted) {
                              ref.read(currentBetProvider.notifier).setBet(bet);
                              if (widget.forMatchmaking) {
                                await ref
                                    .read(matchmakingRepositoryProvider)
                                    .createProposal(clampedBetAmount);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.l10n.waitingForOpponent,
                                      ),
                                    ),
                                  );
                                  context.goNamed('lobby');
                                }
                              } else {
                                context.pushNamed(
                                  'game',
                                  extra: const GameMode.online(),
                                );
                              }
                            }
                          }
                        : null,
                    child: Text(context.l10n.betAmount(clampedBetAmount)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
