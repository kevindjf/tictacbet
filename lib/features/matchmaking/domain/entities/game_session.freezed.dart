// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameSession {

 String get id; String get proposalId; String get playerXId; String get playerOId; SessionStatus get status; String? get winnerId; DateTime get createdAt;
/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSessionCopyWith<GameSession> get copyWith => _$GameSessionCopyWithImpl<GameSession>(this as GameSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSession&&(identical(other.id, id) || other.id == id)&&(identical(other.proposalId, proposalId) || other.proposalId == proposalId)&&(identical(other.playerXId, playerXId) || other.playerXId == playerXId)&&(identical(other.playerOId, playerOId) || other.playerOId == playerOId)&&(identical(other.status, status) || other.status == status)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,proposalId,playerXId,playerOId,status,winnerId,createdAt);

@override
String toString() {
  return 'GameSession(id: $id, proposalId: $proposalId, playerXId: $playerXId, playerOId: $playerOId, status: $status, winnerId: $winnerId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GameSessionCopyWith<$Res>  {
  factory $GameSessionCopyWith(GameSession value, $Res Function(GameSession) _then) = _$GameSessionCopyWithImpl;
@useResult
$Res call({
 String id, String proposalId, String playerXId, String playerOId, SessionStatus status, String? winnerId, DateTime createdAt
});




}
/// @nodoc
class _$GameSessionCopyWithImpl<$Res>
    implements $GameSessionCopyWith<$Res> {
  _$GameSessionCopyWithImpl(this._self, this._then);

  final GameSession _self;
  final $Res Function(GameSession) _then;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? proposalId = null,Object? playerXId = null,Object? playerOId = null,Object? status = null,Object? winnerId = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,proposalId: null == proposalId ? _self.proposalId : proposalId // ignore: cast_nullable_to_non_nullable
as String,playerXId: null == playerXId ? _self.playerXId : playerXId // ignore: cast_nullable_to_non_nullable
as String,playerOId: null == playerOId ? _self.playerOId : playerOId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSession].
extension GameSessionPatterns on GameSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSession value)  $default,){
final _that = this;
switch (_that) {
case _GameSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSession value)?  $default,){
final _that = this;
switch (_that) {
case _GameSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String proposalId,  String playerXId,  String playerOId,  SessionStatus status,  String? winnerId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSession() when $default != null:
return $default(_that.id,_that.proposalId,_that.playerXId,_that.playerOId,_that.status,_that.winnerId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String proposalId,  String playerXId,  String playerOId,  SessionStatus status,  String? winnerId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _GameSession():
return $default(_that.id,_that.proposalId,_that.playerXId,_that.playerOId,_that.status,_that.winnerId,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String proposalId,  String playerXId,  String playerOId,  SessionStatus status,  String? winnerId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GameSession() when $default != null:
return $default(_that.id,_that.proposalId,_that.playerXId,_that.playerOId,_that.status,_that.winnerId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _GameSession implements GameSession {
  const _GameSession({required this.id, required this.proposalId, required this.playerXId, required this.playerOId, required this.status, this.winnerId, required this.createdAt});
  

@override final  String id;
@override final  String proposalId;
@override final  String playerXId;
@override final  String playerOId;
@override final  SessionStatus status;
@override final  String? winnerId;
@override final  DateTime createdAt;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSessionCopyWith<_GameSession> get copyWith => __$GameSessionCopyWithImpl<_GameSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSession&&(identical(other.id, id) || other.id == id)&&(identical(other.proposalId, proposalId) || other.proposalId == proposalId)&&(identical(other.playerXId, playerXId) || other.playerXId == playerXId)&&(identical(other.playerOId, playerOId) || other.playerOId == playerOId)&&(identical(other.status, status) || other.status == status)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,proposalId,playerXId,playerOId,status,winnerId,createdAt);

@override
String toString() {
  return 'GameSession(id: $id, proposalId: $proposalId, playerXId: $playerXId, playerOId: $playerOId, status: $status, winnerId: $winnerId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GameSessionCopyWith<$Res> implements $GameSessionCopyWith<$Res> {
  factory _$GameSessionCopyWith(_GameSession value, $Res Function(_GameSession) _then) = __$GameSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String proposalId, String playerXId, String playerOId, SessionStatus status, String? winnerId, DateTime createdAt
});




}
/// @nodoc
class __$GameSessionCopyWithImpl<$Res>
    implements _$GameSessionCopyWith<$Res> {
  __$GameSessionCopyWithImpl(this._self, this._then);

  final _GameSession _self;
  final $Res Function(_GameSession) _then;

/// Create a copy of GameSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? proposalId = null,Object? playerXId = null,Object? playerOId = null,Object? status = null,Object? winnerId = freezed,Object? createdAt = null,}) {
  return _then(_GameSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,proposalId: null == proposalId ? _self.proposalId : proposalId // ignore: cast_nullable_to_non_nullable
as String,playerXId: null == playerXId ? _self.playerXId : playerXId // ignore: cast_nullable_to_non_nullable
as String,playerOId: null == playerOId ? _self.playerOId : playerOId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
