// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameState {

 Board get board; Player get currentPlayer; GameResult get result; GameMode get mode; List<Move> get moves; bool get isAiThinking;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.board, board) || other.board == board)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.result, result) || other.result == result)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.moves, moves)&&(identical(other.isAiThinking, isAiThinking) || other.isAiThinking == isAiThinking));
}


@override
int get hashCode => Object.hash(runtimeType,board,currentPlayer,result,mode,const DeepCollectionEquality().hash(moves),isAiThinking);

@override
String toString() {
  return 'GameState(board: $board, currentPlayer: $currentPlayer, result: $result, mode: $mode, moves: $moves, isAiThinking: $isAiThinking)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 Board board, Player currentPlayer, GameResult result, GameMode mode, List<Move> moves, bool isAiThinking
});


$BoardCopyWith<$Res> get board;$GameResultCopyWith<$Res> get result;$GameModeCopyWith<$Res> get mode;

}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? board = null,Object? currentPlayer = null,Object? result = null,Object? mode = null,Object? moves = null,Object? isAiThinking = null,}) {
  return _then(_self.copyWith(
board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as Board,currentPlayer: null == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as Player,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as GameResult,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as List<Move>,isAiThinking: null == isAiThinking ? _self.isAiThinking : isAiThinking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardCopyWith<$Res> get board {
  
  return $BoardCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameResultCopyWith<$Res> get result {
  
  return $GameResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameModeCopyWith<$Res> get mode {
  
  return $GameModeCopyWith<$Res>(_self.mode, (value) {
    return _then(_self.copyWith(mode: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Board board,  Player currentPlayer,  GameResult result,  GameMode mode,  List<Move> moves,  bool isAiThinking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.board,_that.currentPlayer,_that.result,_that.mode,_that.moves,_that.isAiThinking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Board board,  Player currentPlayer,  GameResult result,  GameMode mode,  List<Move> moves,  bool isAiThinking)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.board,_that.currentPlayer,_that.result,_that.mode,_that.moves,_that.isAiThinking);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Board board,  Player currentPlayer,  GameResult result,  GameMode mode,  List<Move> moves,  bool isAiThinking)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.board,_that.currentPlayer,_that.result,_that.mode,_that.moves,_that.isAiThinking);case _:
  return null;

}
}

}

/// @nodoc


class _GameState extends GameState {
  const _GameState({required this.board, required this.currentPlayer, required this.result, required this.mode, required final  List<Move> moves, this.isAiThinking = false}): _moves = moves,super._();
  

@override final  Board board;
@override final  Player currentPlayer;
@override final  GameResult result;
@override final  GameMode mode;
 final  List<Move> _moves;
@override List<Move> get moves {
  if (_moves is EqualUnmodifiableListView) return _moves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moves);
}

@override@JsonKey() final  bool isAiThinking;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.board, board) || other.board == board)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.result, result) || other.result == result)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._moves, _moves)&&(identical(other.isAiThinking, isAiThinking) || other.isAiThinking == isAiThinking));
}


@override
int get hashCode => Object.hash(runtimeType,board,currentPlayer,result,mode,const DeepCollectionEquality().hash(_moves),isAiThinking);

@override
String toString() {
  return 'GameState(board: $board, currentPlayer: $currentPlayer, result: $result, mode: $mode, moves: $moves, isAiThinking: $isAiThinking)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 Board board, Player currentPlayer, GameResult result, GameMode mode, List<Move> moves, bool isAiThinking
});


@override $BoardCopyWith<$Res> get board;@override $GameResultCopyWith<$Res> get result;@override $GameModeCopyWith<$Res> get mode;

}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? board = null,Object? currentPlayer = null,Object? result = null,Object? mode = null,Object? moves = null,Object? isAiThinking = null,}) {
  return _then(_GameState(
board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as Board,currentPlayer: null == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as Player,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as GameResult,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GameMode,moves: null == moves ? _self._moves : moves // ignore: cast_nullable_to_non_nullable
as List<Move>,isAiThinking: null == isAiThinking ? _self.isAiThinking : isAiThinking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoardCopyWith<$Res> get board {
  
  return $BoardCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameResultCopyWith<$Res> get result {
  
  return $GameResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of GameState
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
