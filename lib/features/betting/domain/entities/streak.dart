import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak.freezed.dart';

@freezed
sealed class Streak with _$Streak {
  const factory Streak({@Default(0) int count}) = _Streak;

  const Streak._();

  double get multiplier => switch (count) {
    0 => 1.0,
    1 => 1.2,
    2 => 1.5,
    3 => 2.0,
    4 => 2.5,
    _ => 3.0,
  };

  Streak increment() => Streak(count: count + 1);

  Streak reset() => const Streak();
}
