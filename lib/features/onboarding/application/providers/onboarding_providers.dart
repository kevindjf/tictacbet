import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_bet/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:tic_tac_bet/features/onboarding/domain/entities/onboarding_step.dart';

part 'onboarding_providers.g.dart';

@Riverpod(keepAlive: true)
OnboardingLocalDatasource onboardingDatasource(Ref ref) {
  return OnboardingLocalDatasource();
}

@Riverpod(keepAlive: true)
class OnboardingCompleted extends _$OnboardingCompleted {
  @override
  bool build() {
    final ds = ref.read(onboardingDatasourceProvider);
    return ds.isCompleted();
  }

  void setValue(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class OnboardingController extends _$OnboardingController {
  OnboardingLocalDatasource get _datasource => ref.read(onboardingDatasourceProvider);

  @override
  OnboardingStep? build() => null;

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
