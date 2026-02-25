import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref, StateProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/core/entities/game_outcome.dart';
import 'package:tic_tac_bet/features/betting/data/datasources/wallet_local_datasource.dart';
import 'package:tic_tac_bet/features/betting/data/repositories/wallet_repository_impl.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/bet_resolution.dart';
import 'package:tic_tac_bet/features/betting/domain/entities/wallet.dart';
import 'package:tic_tac_bet/features/betting/domain/repositories/wallet_repository.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/place_bet.dart';
import 'package:tic_tac_bet/features/betting/domain/use_cases/resolve_bet.dart';

part 'betting_providers.g.dart';

final betPlacementAmountProvider = StateProvider.autoDispose.family<int, bool>((
  ref,
  forMatchmaking,
) {
  return forMatchmaking ? 1 : Wallet.minimumBet;
});

@Riverpod(keepAlive: true)
WalletLocalDatasource walletDatasource(Ref ref) {
  return WalletLocalDatasource();
}

@Riverpod(keepAlive: true)
WalletRepository walletRepository(Ref ref) {
  return WalletRepositoryImpl(ref.read(walletDatasourceProvider));
}

@Riverpod(keepAlive: true)
PlaceBetUseCase placeBetUseCase(Ref ref) {
  return PlaceBetUseCase();
}

@Riverpod(keepAlive: true)
ResolveBetUseCase resolveBetUseCase(Ref ref) {
  return ResolveBetUseCase();
}

@Riverpod(keepAlive: true)
class WalletController extends _$WalletController {
  WalletRepository get _repository => ref.read(walletRepositoryProvider);

  @override
  Wallet build() {
    Future.microtask(load);
    return const Wallet(balance: Wallet.initialBalance);
  }

  Future<void> load() async {
    state = await _repository.getWallet();
  }

  Future<void> deductBet(int amount) async {
    final newBalance = state.balance - amount;
    await _repository.updateBalance(newBalance);
    state = state.copyWith(balance: newBalance);
  }

  Future<void> addWinnings(int amount) async {
    await _credit(amount);
  }

  Future<void> refundBet(int amount) async {
    await _credit(amount);
  }

  Future<void> _credit(int amount) async {
    final newBalance = state.balance + amount;
    await _repository.updateBalance(newBalance);
    state = state.copyWith(balance: newBalance);
  }

  Future<void> bailout() async {
    await _repository.applyBailout();
    state = await _repository.getWallet();
  }
}

@Riverpod(keepAlive: true)
class CurrentBet extends _$CurrentBet {
  @override
  Bet? build() => null;

  void setBet(Bet? bet) => state = bet;
  void clear() => state = null;
}

class BettingService {
  BettingService(this._ref);

  final Ref _ref;

  PlaceBetUseCase get _placeBet => _ref.read(placeBetUseCaseProvider);
  ResolveBetUseCase get _resolveBet => _ref.read(resolveBetUseCaseProvider);

  Future<Bet?> place(int amount) async {
    final wallet = _ref.read(walletControllerProvider);
    final result = _placeBet(wallet, amount);
    return result.when(
      success: (bet) async {
        await _ref.read(walletControllerProvider.notifier).deductBet(amount);
        return bet;
      },
      failure: (_) => null,
    );
  }

  void cancelPendingBetIfAbandoned({
    required bool isOnline,
    required bool isGameOver,
  }) {
    if (!isOnline || isGameOver) return;
    if (_ref.read(currentBetProvider) == null) return;
    _ref.read(currentBetProvider.notifier).clear();
  }

  Future<BetResolution?> resolve(Bet bet, GameOutcome outcome) async {
    final resolution = _resolveBet(bet, outcome);

    if (resolution.balanceChange > 0) {
      await _ref
          .read(walletControllerProvider.notifier)
          .addWinnings(resolution.balanceChange);
    }

    if (_ref.read(walletControllerProvider).isBankrupt) {
      await _ref.read(walletControllerProvider.notifier).bailout();
    }

    return resolution;
  }
}

@Riverpod(keepAlive: true)
BettingService bettingService(Ref ref) {
  return BettingService(ref);
}

class BetPlacementViewModel {
  const BetPlacementViewModel({
    required this.canPlace,
    required this.clampedAmount,
    required this.wallet,
    required this.potentialWinnings,
  });

  final bool canPlace;
  final int clampedAmount;
  final Wallet wallet;
  final int potentialWinnings;
}

@riverpod
BetPlacementViewModel betPlacementViewModel(Ref ref, bool forMatchmaking) {
  final wallet = ref.watch(walletControllerProvider);
  final rawAmount = ref.watch(betPlacementAmountProvider(forMatchmaking));
  const minimum = Wallet.minimumBet;

  final canPlace = wallet.availableBalance >= minimum;
  final clamped = wallet.availableBalance < minimum
      ? minimum
      : rawAmount.clamp(minimum, wallet.availableBalance);

  return BetPlacementViewModel(
    canPlace: canPlace,
    clampedAmount: clamped,
    wallet: wallet,
    potentialWinnings: clamped * 2,
  );
}
