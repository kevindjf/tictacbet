import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_bet/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';

final onboardingDatasourceProvider = Provider<OnboardingLocalDatasource>((ref) {
  return OnboardingLocalDatasource();
});

final onboardingCompletedProvider = StateProvider<bool>((ref) {
  final ds = ref.read(onboardingDatasourceProvider);
  return ds.isCompleted();
});

class OnboardingNotifier extends StateNotifier<OnboardingStep?> {
  OnboardingNotifier(this._datasource) : super(null);

  final OnboardingLocalDatasource _datasource;

  void start() {
    state = OnboardingStep.welcome;
  }

  void next() {
    if (state == null) return;
    state = state!.next;
    if (state == null) {
      complete();
    }
  }

  void skip() {
    complete();
  }

  void complete() {
    state = null;
    _datasource.markCompleted();
  }

  void reset() {
    _datasource.reset();
  }
}

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingStep?>((ref) {
      return OnboardingNotifier(ref.read(onboardingDatasourceProvider));
    });
