import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/betting/data/datasources/wallet_local_datasource.dart';
import 'package:tic_tac_bet/features/betting/data/repositories/wallet_repository_impl.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/streak.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/domain/repositories/wallet_repository.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/place_bet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/resolve_bet.dart';
import 'package:tic_tac_bet/features/history/domain/entities/game_history_entry.dart';

final walletDatasourceProvider = Provider<WalletLocalDatasource>((ref) {
  return WalletLocalDatasource();
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepositoryImpl(ref.read(walletDatasourceProvider));
});

final placeBetUseCaseProvider = Provider<PlaceBetUseCase>((ref) {
  return PlaceBetUseCase();
});

final resolveBetUseCaseProvider = Provider<ResolveBetUseCase>((ref) {
  return ResolveBetUseCase();
});

class WalletNotifier extends StateNotifier<Wallet> {
  WalletNotifier(this._repository)
    : super(const Wallet(balance: Wallet.initialBalance));

  final WalletRepository _repository;

  Future<void> load() async {
    state = await _repository.getWallet();
  }

  Future<void> deductBet(int amount) async {
    final newBalance = state.balance - amount;
    await _repository.updateBalance(newBalance);
    state = state.copyWith(balance: newBalance);
  }

  Future<void> addWinnings(int amount) async {
    final newBalance = state.balance + amount;
    await _repository.updateBalance(newBalance);
    state = state.copyWith(balance: newBalance);
  }

  Future<void> refundBet(int amount) async {
    final newBalance = state.balance + amount;
    await _repository.updateBalance(newBalance);
    state = state.copyWith(balance: newBalance);
  }

  Future<void> bailout() async {
    await _repository.applyBailout();
    state = await _repository.getWallet();
  }
}

final walletNotifierProvider = StateNotifierProvider<WalletNotifier, Wallet>((
  ref,
) {
  return WalletNotifier(ref.read(walletRepositoryProvider));
});

class StreakNotifier extends StateNotifier<Streak> {
  StreakNotifier(this._repository) : super(const Streak());

  final WalletRepository _repository;

  Future<void> load() async {
    state = await _repository.getStreak();
  }

  Future<void> update(Streak streak) async {
    state = streak;
    await _repository.updateStreak(streak);
  }
}

final streakNotifierProvider = StateNotifierProvider<StreakNotifier, Streak>((
  ref,
) {
  return StreakNotifier(ref.read(walletRepositoryProvider));
});

final currentBetProvider = StateProvider<Bet?>((ref) => null);

class BettingService {
  BettingService(this._ref);

  final Ref _ref;

  PlaceBetUseCase get _placeBet => _ref.read(placeBetUseCaseProvider);
  ResolveBetUseCase get _resolveBet => _ref.read(resolveBetUseCaseProvider);

  Future<Bet?> place(int amount) async {
    final wallet = _ref.read(walletNotifierProvider);
    final streak = _ref.read(streakNotifierProvider);
    final result = _placeBet(wallet, amount, streak);
    return result.when(
      success: (bet) async {
        await _ref.read(walletNotifierProvider.notifier).deductBet(amount);
        return bet;
      },
      failure: (_) => null,
    );
  }

  Future<BetResolution?> resolve(Bet bet, GameOutcome outcome) async {
    final streak = _ref.read(streakNotifierProvider);
    final resolution = _resolveBet(bet, outcome, streak.count);

    if (resolution.balanceChange > 0) {
      await _ref
          .read(walletNotifierProvider.notifier)
          .addWinnings(resolution.balanceChange);
    }

    await _ref
        .read(streakNotifierProvider.notifier)
        .update(Streak(count: resolution.newStreakCount));

    if (_ref.read(walletNotifierProvider).isBankrupt) {
      await _ref.read(walletNotifierProvider.notifier).bailout();
    }

    return resolution;
  }
}

final bettingServiceProvider = Provider<BettingService>((ref) {
  return BettingService(ref);
});
