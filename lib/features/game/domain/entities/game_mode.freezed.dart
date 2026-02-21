// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameMode {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameMode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameMode()';
}


}

/// @nodoc
class $GameModeCopyWith<$Res>  {
$GameModeCopyWith(GameMode _, $Res Function(GameMode) __);
}


/// Adds pattern-matching-related methods to [GameMode].
extension GameModePatterns on GameMode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameModeVsAi value)?  vsAi,TResult Function( GameModeVsLocal value)?  vsLocal,TResult Function( GameModeOnline value)?  online,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameModeVsAi() when vsAi != null:
return vsAi(_that);case GameModeVsLocal() when vsLocal != null:
return vsLocal(_that);case GameModeOnline() when online != null:
return online(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameModeVsAi value)  vsAi,required TResult Function( GameModeVsLocal value)  vsLocal,required TResult Function( GameModeOnline value)  online,}){
final _that = this;
switch (_that) {
case GameModeVsAi():
return vsAi(_that);case GameModeVsLocal():
return vsLocal(_that);case GameModeOnline():
return online(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameModeVsAi value)?  vsAi,TResult? Function( GameModeVsLocal value)?  vsLocal,TResult? Function( GameModeOnline value)?  online,}){
final _that = this;
switch (_that) {
case GameModeVsAi() when vsAi != null:
return vsAi(_that);case GameModeVsLocal() when vsLocal != null:
return vsLocal(_that);case GameModeOnline() when online != null:
return online(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Difficulty difficulty)?  vsAi,TResult Function()?  vsLocal,TResult Function()?  online,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameModeVsAi() when vsAi != null:
return vsAi(_that.difficulty);case GameModeVsLocal() when vsLocal != null:
return vsLocal();case GameModeOnline() when online != null:
return online();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Difficulty difficulty)  vsAi,required TResult Function()  vsLocal,required TResult Function()  online,}) {final _that = this;
switch (_that) {
case GameModeVsAi():
return vsAi(_that.difficulty);case GameModeVsLocal():
return vsLocal();case GameModeOnline():
return online();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Difficulty difficulty)?  vsAi,TResult? Function()?  vsLocal,TResult? Function()?  online,}) {final _that = this;
switch (_that) {
case GameModeVsAi() when vsAi != null:
return vsAi(_that.difficulty);case GameModeVsLocal() when vsLocal != null:
return vsLocal();case GameModeOnline() when online != null:
return online();case _:
  return null;

}
}

}

/// @nodoc


class GameModeVsAi implements GameMode {
  const GameModeVsAi({required this.difficulty});
  

 final  Difficulty difficulty;

/// Create a copy of GameMode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameModeVsAiCopyWith<GameModeVsAi> get copyWith => _$GameModeVsAiCopyWithImpl<GameModeVsAi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameModeVsAi&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty));
}


@override
int get hashCode => Object.hash(runtimeType,difficulty);

@override
String toString() {
  return 'GameMode.vsAi(difficulty: $difficulty)';
}


}

/// @nodoc
abstract mixin class $GameModeVsAiCopyWith<$Res> implements $GameModeCopyWith<$Res> {
  factory $GameModeVsAiCopyWith(GameModeVsAi value, $Res Function(GameModeVsAi) _then) = _$GameModeVsAiCopyWithImpl;
@useResult
$Res call({
 Difficulty difficulty
});




}
/// @nodoc
class _$GameModeVsAiCopyWithImpl<$Res>
    implements $GameModeVsAiCopyWith<$Res> {
  _$GameModeVsAiCopyWithImpl(this._self, this._then);

  final GameModeVsAi _self;
  final $Res Function(GameModeVsAi) _then;

/// Create a copy of GameMode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? difficulty = null,}) {
  return _then(GameModeVsAi(
difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,
  ));
}


}

/// @nodoc


class GameModeVsLocal implements GameMode {
  const GameModeVsLocal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameModeVsLocal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameMode.vsLocal()';
}


}




/// @nodoc


class GameModeOnline implements GameMode {
  const GameModeOnline();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameModeOnline);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameMode.online()';
}


}




// dart format on
