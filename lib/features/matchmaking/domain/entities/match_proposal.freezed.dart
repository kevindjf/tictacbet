// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_proposal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchProposal {

 String get id; String get creatorId; String get creatorName; int get betAmount; MatchStatus get status; String? get opponentId; DateTime get createdAt; DateTime get expiresAt;
/// Create a copy of MatchProposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchProposalCopyWith<MatchProposal> get copyWith => _$MatchProposalCopyWithImpl<MatchProposal>(this as MatchProposal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.betAmount, betAmount) || other.betAmount == betAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,creatorId,creatorName,betAmount,status,opponentId,createdAt,expiresAt);

@override
String toString() {
  return 'MatchProposal(id: $id, creatorId: $creatorId, creatorName: $creatorName, betAmount: $betAmount, status: $status, opponentId: $opponentId, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $MatchProposalCopyWith<$Res>  {
  factory $MatchProposalCopyWith(MatchProposal value, $Res Function(MatchProposal) _then) = _$MatchProposalCopyWithImpl;
@useResult
$Res call({
 String id, String creatorId, String creatorName, int betAmount, MatchStatus status, String? opponentId, DateTime createdAt, DateTime expiresAt
});




}
/// @nodoc
class _$MatchProposalCopyWithImpl<$Res>
    implements $MatchProposalCopyWith<$Res> {
  _$MatchProposalCopyWithImpl(this._self, this._then);

  final MatchProposal _self;
  final $Res Function(MatchProposal) _then;

/// Create a copy of MatchProposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? creatorId = null,Object? creatorName = null,Object? betAmount = null,Object? status = null,Object? opponentId = freezed,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,creatorName: null == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String,betAmount: null == betAmount ? _self.betAmount : betAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchProposal].
extension MatchProposalPatterns on MatchProposal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchProposal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchProposal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchProposal value)  $default,){
final _that = this;
switch (_that) {
case _MatchProposal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchProposal value)?  $default,){
final _that = this;
switch (_that) {
case _MatchProposal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String creatorId,  String creatorName,  int betAmount,  MatchStatus status,  String? opponentId,  DateTime createdAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchProposal() when $default != null:
return $default(_that.id,_that.creatorId,_that.creatorName,_that.betAmount,_that.status,_that.opponentId,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String creatorId,  String creatorName,  int betAmount,  MatchStatus status,  String? opponentId,  DateTime createdAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _MatchProposal():
return $default(_that.id,_that.creatorId,_that.creatorName,_that.betAmount,_that.status,_that.opponentId,_that.createdAt,_that.expiresAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String creatorId,  String creatorName,  int betAmount,  MatchStatus status,  String? opponentId,  DateTime createdAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _MatchProposal() when $default != null:
return $default(_that.id,_that.creatorId,_that.creatorName,_that.betAmount,_that.status,_that.opponentId,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _MatchProposal extends MatchProposal {
  const _MatchProposal({required this.id, required this.creatorId, required this.creatorName, required this.betAmount, required this.status, this.opponentId, required this.createdAt, required this.expiresAt}): super._();
  

@override final  String id;
@override final  String creatorId;
@override final  String creatorName;
@override final  int betAmount;
@override final  MatchStatus status;
@override final  String? opponentId;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;

/// Create a copy of MatchProposal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchProposalCopyWith<_MatchProposal> get copyWith => __$MatchProposalCopyWithImpl<_MatchProposal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.betAmount, betAmount) || other.betAmount == betAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,creatorId,creatorName,betAmount,status,opponentId,createdAt,expiresAt);

@override
String toString() {
  return 'MatchProposal(id: $id, creatorId: $creatorId, creatorName: $creatorName, betAmount: $betAmount, status: $status, opponentId: $opponentId, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$MatchProposalCopyWith<$Res> implements $MatchProposalCopyWith<$Res> {
  factory _$MatchProposalCopyWith(_MatchProposal value, $Res Function(_MatchProposal) _then) = __$MatchProposalCopyWithImpl;
@override @useResult
$Res call({
 String id, String creatorId, String creatorName, int betAmount, MatchStatus status, String? opponentId, DateTime createdAt, DateTime expiresAt
});




}
/// @nodoc
class __$MatchProposalCopyWithImpl<$Res>
    implements _$MatchProposalCopyWith<$Res> {
  __$MatchProposalCopyWithImpl(this._self, this._then);

  final _MatchProposal _self;
  final $Res Function(_MatchProposal) _then;

/// Create a copy of MatchProposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? creatorId = null,Object? creatorName = null,Object? betAmount = null,Object? status = null,Object? opponentId = freezed,Object? createdAt = null,Object? expiresAt = null,}) {
  return _then(_MatchProposal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,creatorName: null == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String,betAmount: null == betAmount ? _self.betAmount : betAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,opponentId: freezed == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
