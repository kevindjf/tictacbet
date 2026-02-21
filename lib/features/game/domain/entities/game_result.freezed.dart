// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameResult()';
}


}

/// @nodoc
class $GameResultCopyWith<$Res>  {
$GameResultCopyWith(GameResult _, $Res Function(GameResult) __);
}


/// Adds pattern-matching-related methods to [GameResult].
extension GameResultPatterns on GameResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameResultOngoing value)?  ongoing,TResult Function( GameResultWin value)?  win,TResult Function( GameResultDraw value)?  draw,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameResultOngoing() when ongoing != null:
return ongoing(_that);case GameResultWin() when win != null:
return win(_that);case GameResultDraw() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameResultOngoing value)  ongoing,required TResult Function( GameResultWin value)  win,required TResult Function( GameResultDraw value)  draw,}){
final _that = this;
switch (_that) {
case GameResultOngoing():
return ongoing(_that);case GameResultWin():
return win(_that);case GameResultDraw():
return draw(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameResultOngoing value)?  ongoing,TResult? Function( GameResultWin value)?  win,TResult? Function( GameResultDraw value)?  draw,}){
final _that = this;
switch (_that) {
case GameResultOngoing() when ongoing != null:
return ongoing(_that);case GameResultWin() when win != null:
return win(_that);case GameResultDraw() when draw != null:
return draw(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  ongoing,TResult Function( Player winner,  List<(int, int)> winningLine)?  win,TResult Function()?  draw,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameResultOngoing() when ongoing != null:
return ongoing();case GameResultWin() when win != null:
return win(_that.winner,_that.winningLine);case GameResultDraw() when draw != null:
return draw();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  ongoing,required TResult Function( Player winner,  List<(int, int)> winningLine)  win,required TResult Function()  draw,}) {final _that = this;
switch (_that) {
case GameResultOngoing():
return ongoing();case GameResultWin():
return win(_that.winner,_that.winningLine);case GameResultDraw():
return draw();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  ongoing,TResult? Function( Player winner,  List<(int, int)> winningLine)?  win,TResult? Function()?  draw,}) {final _that = this;
switch (_that) {
case GameResultOngoing() when ongoing != null:
return ongoing();case GameResultWin() when win != null:
return win(_that.winner,_that.winningLine);case GameResultDraw() when draw != null:
return draw();case _:
  return null;

}
}

}

/// @nodoc


class GameResultOngoing implements GameResult {
  const GameResultOngoing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResultOngoing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameResult.ongoing()';
}


}




/// @nodoc


class GameResultWin implements GameResult {
  const GameResultWin({required this.winner, required final  List<(int, int)> winningLine}): _winningLine = winningLine;
  

 final  Player winner;
 final  List<(int, int)> _winningLine;
 List<(int, int)> get winningLine {
  if (_winningLine is EqualUnmodifiableListView) return _winningLine;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winningLine);
}


/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameResultWinCopyWith<GameResultWin> get copyWith => _$GameResultWinCopyWithImpl<GameResultWin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResultWin&&(identical(other.winner, winner) || other.winner == winner)&&const DeepCollectionEquality().equals(other._winningLine, _winningLine));
}


@override
int get hashCode => Object.hash(runtimeType,winner,const DeepCollectionEquality().hash(_winningLine));

@override
String toString() {
  return 'GameResult.win(winner: $winner, winningLine: $winningLine)';
}


}

/// @nodoc
abstract mixin class $GameResultWinCopyWith<$Res> implements $GameResultCopyWith<$Res> {
  factory $GameResultWinCopyWith(GameResultWin value, $Res Function(GameResultWin) _then) = _$GameResultWinCopyWithImpl;
@useResult
$Res call({
 Player winner, List<(int, int)> winningLine
});




}
/// @nodoc
class _$GameResultWinCopyWithImpl<$Res>
    implements $GameResultWinCopyWith<$Res> {
  _$GameResultWinCopyWithImpl(this._self, this._then);

  final GameResultWin _self;
  final $Res Function(GameResultWin) _then;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? winner = null,Object? winningLine = null,}) {
  return _then(GameResultWin(
winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as Player,winningLine: null == winningLine ? _self._winningLine : winningLine // ignore: cast_nullable_to_non_nullable
as List<(int, int)>,
  ));
}


}

/// @nodoc


class GameResultDraw implements GameResult {
  const GameResultDraw();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResultDraw);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameResult.draw()';
}


}




// dart format on
