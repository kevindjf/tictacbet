// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameStatistics {

 int get totalGames; int get wins; int get losses; int get draws; int get totalCoinsWon; int get totalCoinsLost; int get bestStreak;
/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStatisticsCopyWith<GameStatistics> get copyWith => _$GameStatisticsCopyWithImpl<GameStatistics>(this as GameStatistics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatistics&&(identical(other.totalGames, totalGames) || other.totalGames == totalGames)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.totalCoinsWon, totalCoinsWon) || other.totalCoinsWon == totalCoinsWon)&&(identical(other.totalCoinsLost, totalCoinsLost) || other.totalCoinsLost == totalCoinsLost)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak));
}


@override
int get hashCode => Object.hash(runtimeType,totalGames,wins,losses,draws,totalCoinsWon,totalCoinsLost,bestStreak);

@override
String toString() {
  return 'GameStatistics(totalGames: $totalGames, wins: $wins, losses: $losses, draws: $draws, totalCoinsWon: $totalCoinsWon, totalCoinsLost: $totalCoinsLost, bestStreak: $bestStreak)';
}


}

/// @nodoc
abstract mixin class $GameStatisticsCopyWith<$Res>  {
  factory $GameStatisticsCopyWith(GameStatistics value, $Res Function(GameStatistics) _then) = _$GameStatisticsCopyWithImpl;
@useResult
$Res call({
 int totalGames, int wins, int losses, int draws, int totalCoinsWon, int totalCoinsLost, int bestStreak
});




}
/// @nodoc
class _$GameStatisticsCopyWithImpl<$Res>
    implements $GameStatisticsCopyWith<$Res> {
  _$GameStatisticsCopyWithImpl(this._self, this._then);

  final GameStatistics _self;
  final $Res Function(GameStatistics) _then;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalGames = null,Object? wins = null,Object? losses = null,Object? draws = null,Object? totalCoinsWon = null,Object? totalCoinsLost = null,Object? bestStreak = null,}) {
  return _then(_self.copyWith(
totalGames: null == totalGames ? _self.totalGames : totalGames // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,totalCoinsWon: null == totalCoinsWon ? _self.totalCoinsWon : totalCoinsWon // ignore: cast_nullable_to_non_nullable
as int,totalCoinsLost: null == totalCoinsLost ? _self.totalCoinsLost : totalCoinsLost // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameStatistics].
extension GameStatisticsPatterns on GameStatistics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameStatistics value)  $default,){
final _that = this;
switch (_that) {
case _GameStatistics():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalGames,  int wins,  int losses,  int draws,  int totalCoinsWon,  int totalCoinsLost,  int bestStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that.totalGames,_that.wins,_that.losses,_that.draws,_that.totalCoinsWon,_that.totalCoinsLost,_that.bestStreak);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalGames,  int wins,  int losses,  int draws,  int totalCoinsWon,  int totalCoinsLost,  int bestStreak)  $default,) {final _that = this;
switch (_that) {
case _GameStatistics():
return $default(_that.totalGames,_that.wins,_that.losses,_that.draws,_that.totalCoinsWon,_that.totalCoinsLost,_that.bestStreak);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalGames,  int wins,  int losses,  int draws,  int totalCoinsWon,  int totalCoinsLost,  int bestStreak)?  $default,) {final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that.totalGames,_that.wins,_that.losses,_that.draws,_that.totalCoinsWon,_that.totalCoinsLost,_that.bestStreak);case _:
  return null;

}
}

}

/// @nodoc


class _GameStatistics extends GameStatistics {
  const _GameStatistics({this.totalGames = 0, this.wins = 0, this.losses = 0, this.draws = 0, this.totalCoinsWon = 0, this.totalCoinsLost = 0, this.bestStreak = 0}): super._();
  

@override@JsonKey() final  int totalGames;
@override@JsonKey() final  int wins;
@override@JsonKey() final  int losses;
@override@JsonKey() final  int draws;
@override@JsonKey() final  int totalCoinsWon;
@override@JsonKey() final  int totalCoinsLost;
@override@JsonKey() final  int bestStreak;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStatisticsCopyWith<_GameStatistics> get copyWith => __$GameStatisticsCopyWithImpl<_GameStatistics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameStatistics&&(identical(other.totalGames, totalGames) || other.totalGames == totalGames)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.totalCoinsWon, totalCoinsWon) || other.totalCoinsWon == totalCoinsWon)&&(identical(other.totalCoinsLost, totalCoinsLost) || other.totalCoinsLost == totalCoinsLost)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak));
}


@override
int get hashCode => Object.hash(runtimeType,totalGames,wins,losses,draws,totalCoinsWon,totalCoinsLost,bestStreak);

@override
String toString() {
  return 'GameStatistics(totalGames: $totalGames, wins: $wins, losses: $losses, draws: $draws, totalCoinsWon: $totalCoinsWon, totalCoinsLost: $totalCoinsLost, bestStreak: $bestStreak)';
}


}

/// @nodoc
abstract mixin class _$GameStatisticsCopyWith<$Res> implements $GameStatisticsCopyWith<$Res> {
  factory _$GameStatisticsCopyWith(_GameStatistics value, $Res Function(_GameStatistics) _then) = __$GameStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int totalGames, int wins, int losses, int draws, int totalCoinsWon, int totalCoinsLost, int bestStreak
});




}
/// @nodoc
class __$GameStatisticsCopyWithImpl<$Res>
    implements _$GameStatisticsCopyWith<$Res> {
  __$GameStatisticsCopyWithImpl(this._self, this._then);

  final _GameStatistics _self;
  final $Res Function(_GameStatistics) _then;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalGames = null,Object? wins = null,Object? losses = null,Object? draws = null,Object? totalCoinsWon = null,Object? totalCoinsLost = null,Object? bestStreak = null,}) {
  return _then(_GameStatistics(
totalGames: null == totalGames ? _self.totalGames : totalGames // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,totalCoinsWon: null == totalCoinsWon ? _self.totalCoinsWon : totalCoinsWon // ignore: cast_nullable_to_non_nullable
as int,totalCoinsLost: null == totalCoinsLost ? _self.totalCoinsLost : totalCoinsLost // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
