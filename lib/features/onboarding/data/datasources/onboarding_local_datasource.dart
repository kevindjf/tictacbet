import 'package:hive_ce/hive.dart';

class OnboardingLocalDatasource {
  static const String boxName = 'onboarding';

  Box<dynamic> get _box => Hive.box(boxName);

  bool isCompleted() => _box.get('completed', defaultValue: false) as bool;

  Future<void> markCompleted() => _box.put('completed', true);

  Future<void> reset() => _box.put('completed', false);
}
