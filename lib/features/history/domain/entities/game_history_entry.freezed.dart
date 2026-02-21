// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameHistoryEntry {

 String get id; DateTime get playedAt; GameMode get mode; GameOutcome get outcome; Player get playerSide; List<Move> get moves; int? get betAmount; int? get coinsWon;
/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryEntryCopyWith<GameHistoryEntry> get copyWith => _$GameHistoryEntryCopyWithImpl<GameHistoryEntry>(this as GameHistoryEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.playerSide, playerSide) || other.playerSide == playerSide)&&const DeepCollectionEquality().equals(other.moves, moves)&&(identical(other.betAmount, betAmount) || other.betAmount == betAmount)&&(identical(other.coinsWon, coinsWon) || other.coinsWon == coinsWon));
}


@override
int get hashCode => Object.hash(runtimeType,id,playedAt,mode,outcome,playerSide,const DeepCollectionEquality().hash(moves),betAmount,coinsWon);

@override
String toString() {
  return 'GameHistoryEntry(id: $id, playedAt: $playedAt, mode: $mode, outcome: $outcome, playerSide: $playerSide, moves: $moves, betAmount: $betAmount, coinsWon: $coinsWon)';
}


}

/// @nodoc
abstract mixin class $GameHistoryEntryCopyWith<$Res>  {
  factory $GameHistoryEntryCopyWith(GameHistoryEntry value, $Res Function(GameHistoryEntry) _then) = _$GameHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime playedAt, GameMode mode, GameOutcome outcome, Player playerSide, List<Move> moves, int? betAmount, int? coinsWon
});


$GameModeCopyWith<$Res> get mode;

}
/// @nodoc
class _$GameHistoryEntryCopyWithImpl<$Res>
    implements $GameHistoryEntryCopyWith<$Res> {
  _$GameHistoryEntryCopyWithImpl(this._self, this._then);

  final GameHistoryEntry _self;
  final $Res Function(GameHistoryEntry) _then;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playedAt = null,Object? mode = null,Object? outcome = null,Object? playerSide = null,Object? moves = null,Object? betAmount = freezed,Object? coinsWon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as GameOutcome,playerSide: null == playerSide ? _self.playerSide : playerSide // ignore: cast_nullable_to_non_nullable
as Player,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as List<Move>,betAmount: freezed == betAmount ? _self.betAmount : betAmount // ignore: cast_nullable_to_non_nullable
as int?,coinsWon: freezed == coinsWon ? _self.coinsWon : coinsWon // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameModeCopyWith<$Res> get mode {
  
  return $GameModeCopyWith<$Res>(_self.mode, (value) {
    return _then(_self.copyWith(mode: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameHistoryEntry].
extension GameHistoryEntryPatterns on GameHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _GameHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime playedAt,  GameMode mode,  GameOutcome outcome,  Player playerSide,  List<Move> moves,  int? betAmount,  int? coinsWon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
return $default(_that.id,_that.playedAt,_that.mode,_that.outcome,_that.playerSide,_that.moves,_that.betAmount,_that.coinsWon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime playedAt,  GameMode mode,  GameOutcome outcome,  Player playerSide,  List<Move> moves,  int? betAmount,  int? coinsWon)  $default,) {final _that = this;
switch (_that) {
case _GameHistoryEntry():
return $default(_that.id,_that.playedAt,_that.mode,_that.outcome,_that.playerSide,_that.moves,_that.betAmount,_that.coinsWon);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime playedAt,  GameMode mode,  GameOutcome outcome,  Player playerSide,  List<Move> moves,  int? betAmount,  int? coinsWon)?  $default,) {final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
return $default(_that.id,_that.playedAt,_that.mode,_that.outcome,_that.playerSide,_that.moves,_that.betAmount,_that.coinsWon);case _:
  return null;

}
}

}

/// @nodoc


class _GameHistoryEntry implements GameHistoryEntry {
  const _GameHistoryEntry({required this.id, required this.playedAt, required this.mode, required this.outcome, required this.playerSide, required final  List<Move> moves, this.betAmount, this.coinsWon}): _moves = moves;
  

@override final  String id;
@override final  DateTime playedAt;
@override final  GameMode mode;
@override final  GameOutcome outcome;
@override final  Player playerSide;
 final  List<Move> _moves;
@override List<Move> get moves {
  if (_moves is EqualUnmodifiableListView) return _moves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moves);
}

@override final  int? betAmount;
@override final  int? coinsWon;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameHistoryEntryCopyWith<_GameHistoryEntry> get copyWith => __$GameHistoryEntryCopyWithImpl<_GameHistoryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.playerSide, playerSide) || other.playerSide == playerSide)&&const DeepCollectionEquality().equals(other._moves, _moves)&&(identical(other.betAmount, betAmount) || other.betAmount == betAmount)&&(identical(other.coinsWon, coinsWon) || other.coinsWon == coinsWon));
}


@override
int get hashCode => Object.hash(runtimeType,id,playedAt,mode,outcome,playerSide,const DeepCollectionEquality().hash(_moves),betAmount,coinsWon);

@override
String toString() {
  return 'GameHistoryEntry(id: $id, playedAt: $playedAt, mode: $mode, outcome: $outcome, playerSide: $playerSide, moves: $moves, betAmount: $betAmount, coinsWon: $coinsWon)';
}


}

/// @nodoc
abstract mixin class _$GameHistoryEntryCopyWith<$Res> implements $GameHistoryEntryCopyWith<$Res> {
  factory _$GameHistoryEntryCopyWith(_GameHistoryEntry value, $Res Function(_GameHistoryEntry) _then) = __$GameHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime playedAt, GameMode mode, GameOutcome outcome, Player playerSide, List<Move> moves, int? betAmount, int? coinsWon
});


@override $GameModeCopyWith<$Res> get mode;

}
/// @nodoc
class __$GameHistoryEntryCopyWithImpl<$Res>
    implements _$GameHistoryEntryCopyWith<$Res> {
  __$GameHistoryEntryCopyWithImpl(this._self, this._then);

  final _GameHistoryEntry _self;
  final $Res Function(_GameHistoryEntry) _then;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playedAt = null,Object? mode = null,Object? outcome = null,Object? playerSide = null,Object? moves = null,Object? betAmount = freezed,Object? coinsWon = freezed,}) {
  return _then(_GameHistoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as GameOutcome,playerSide: null == playerSide ? _self.playerSide : playerSide // ignore: cast_nullable_to_non_nullable
as Player,moves: null == moves ? _self._moves : moves // ignore: cast_nullable_to_non_nullable
as List<Move>,betAmount: freezed == betAmount ? _self.betAmount : betAmount // ignore: cast_nullable_to_non_nullable
as int?,coinsWon: freezed == coinsWon ? _self.coinsWon : coinsWon // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameModeCopyWith<$Res> get mode {
  
  return $GameModeCopyWith<$Res>(_self.mode, (value) {
    return _then(_self.copyWith(mode: value));
  });
}
}

// dart format on
