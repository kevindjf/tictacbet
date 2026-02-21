import 'package:hive_ce/hive.dart';

class WalletLocalDatasource {
  static const String boxName = 'wallet';

  Box<dynamic> get _box => Hive.box(boxName);

  int getBalance() => _box.get('balance', defaultValue: 1000) as int;

  Future<void> setBalance(int balance) => _box.put('balance', balance);

  int getStreakCount() => _box.get('streakCount', defaultValue: 0) as int;

  Future<void> setStreakCount(int count) => _box.put('streakCount', count);

  int getBailoutCount() => _box.get('bailoutCount', defaultValue: 0) as int;

  Future<void> setBailoutCount(int count) => _box.put('bailoutCount', count);
}
