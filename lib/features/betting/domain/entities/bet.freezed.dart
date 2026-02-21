// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Bet {

 int get amount; double get multiplier;
/// Create a copy of Bet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BetCopyWith<Bet> get copyWith => _$BetCopyWithImpl<Bet>(this as Bet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bet&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier));
}


@override
int get hashCode => Object.hash(runtimeType,amount,multiplier);

@override
String toString() {
  return 'Bet(amount: $amount, multiplier: $multiplier)';
}


}

/// @nodoc
abstract mixin class $BetCopyWith<$Res>  {
  factory $BetCopyWith(Bet value, $Res Function(Bet) _then) = _$BetCopyWithImpl;
@useResult
$Res call({
 int amount, double multiplier
});




}
/// @nodoc
class _$BetCopyWithImpl<$Res>
    implements $BetCopyWith<$Res> {
  _$BetCopyWithImpl(this._self, this._then);

  final Bet _self;
  final $Res Function(Bet) _then;

/// Create a copy of Bet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? multiplier = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Bet].
extension BetPatterns on Bet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bet value)  $default,){
final _that = this;
switch (_that) {
case _Bet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bet value)?  $default,){
final _that = this;
switch (_that) {
case _Bet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  double multiplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bet() when $default != null:
return $default(_that.amount,_that.multiplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  double multiplier)  $default,) {final _that = this;
switch (_that) {
case _Bet():
return $default(_that.amount,_that.multiplier);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  double multiplier)?  $default,) {final _that = this;
switch (_that) {
case _Bet() when $default != null:
return $default(_that.amount,_that.multiplier);case _:
  return null;

}
}

}

/// @nodoc


class _Bet extends Bet {
  const _Bet({required this.amount, required this.multiplier}): super._();
  

@override final  int amount;
@override final  double multiplier;

/// Create a copy of Bet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BetCopyWith<_Bet> get copyWith => __$BetCopyWithImpl<_Bet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bet&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier));
}


@override
int get hashCode => Object.hash(runtimeType,amount,multiplier);

@override
String toString() {
  return 'Bet(amount: $amount, multiplier: $multiplier)';
}


}

/// @nodoc
abstract mixin class _$BetCopyWith<$Res> implements $BetCopyWith<$Res> {
  factory _$BetCopyWith(_Bet value, $Res Function(_Bet) _then) = __$BetCopyWithImpl;
@override @useResult
$Res call({
 int amount, double multiplier
});




}
/// @nodoc
class __$BetCopyWithImpl<$Res>
    implements _$BetCopyWith<$Res> {
  __$BetCopyWithImpl(this._self, this._then);

  final _Bet _self;
  final $Res Function(_Bet) _then;

/// Create a copy of Bet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? multiplier = null,}) {
  return _then(_Bet(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
