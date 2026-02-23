import 'package:hive_ce/hive.dart';
import 'package:tic_tac_bet/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Hive-backed implementation of [OnboardingRepository].
///
/// Persists a single boolean flag named `completed` inside the onboarding box.
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._box);

  static const String boxName = 'onboarding';

  final Box<dynamic> _box;

  @override
  bool isCompleted() => _box.get('completed', defaultValue: false) == true;

  @override
  Future<void> markCompleted() => _box.put('completed', true);

  @override
  Future<void> reset() => _box.put('completed', false);
}
