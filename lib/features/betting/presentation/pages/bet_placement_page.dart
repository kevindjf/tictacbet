import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_bet/core/constants/app_dimensions.dart';
import 'package:tic_tac_bet/core/utils/l10n_extension.dart';
import 'package:tic_tac_bet/features/betting/application/providers/betting_providers.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/bet_slider.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/coin_balance.dart';
import 'package:tic_tac_bet/features/betting/presentation/widgets/streak_display.dart';
import 'package:tic_tac_bet/features/game/domain/entities/game_mode.dart';

class BetPlacementPage extends ConsumerStatefulWidget {
  const BetPlacementPage({super.key});

  @override
  ConsumerState<BetPlacementPage> createState() => _BetPlacementPageState();
}

class _BetPlacementPageState extends ConsumerState<BetPlacementPage> {
  int _betAmount = Wallet.minimumBet;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletNotifierProvider.notifier).load();
      ref.read(streakNotifierProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletNotifierProvider);
    final streak = ref.watch(streakNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.placeBet)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          child: Column(
            children: [
              CoinBalance(balance: wallet.balance),
              const SizedBox(height: AppDimensions.spacingL),
              StreakDisplay(streak: streak),
              const Spacer(),
              BetSlider(
                currentBet: _betAmount,
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
                  onPressed: wallet.canBet(_betAmount)
                      ? () async {
                          final bet = await ref
                              .read(bettingServiceProvider)
                              .place(_betAmount);
                          if (bet != null && context.mounted) {
                            ref.read(currentBetProvider.notifier).state = bet;
                            context.pushNamed(
                              'game',
                              extra: const GameMode.online(),
                            );
                          }
                        }
                      : null,
                  child: Text(context.l10n.betAmount(_betAmount)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
