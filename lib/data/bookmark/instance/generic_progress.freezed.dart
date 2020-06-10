// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'generic_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GenericProgress _$GenericProgressFromJson(Map<String, dynamic> json) {
  return _GenericProgress.fromJson(json);
}

class _$GenericProgressTearOff {
  const _$GenericProgressTearOff();

  _GenericProgress call(
      @JsonKey(required: true)
          DateTime date,
      @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
          Rational value) {
    return _GenericProgress(
      date,
      value,
    );
  }
}

// ignore: unused_element
const $GenericProgress = _$GenericProgressTearOff();

mixin _$GenericProgress {
  @JsonKey(required: true)
  DateTime get date;
  @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
  Rational get value;

  Map<String, dynamic> toJson();
  $GenericProgressCopyWith<GenericProgress> get copyWith;
}

abstract class $GenericProgressCopyWith<$Res> {
  factory $GenericProgressCopyWith(
          GenericProgress value, $Res Function(GenericProgress) then) =
      _$GenericProgressCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(required: true)
          DateTime date,
      @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
          Rational value});
}

class _$GenericProgressCopyWithImpl<$Res>
    implements $GenericProgressCopyWith<$Res> {
  _$GenericProgressCopyWithImpl(this._value, this._then);

  final GenericProgress _value;
  // ignore: unused_field
  final $Res Function(GenericProgress) _then;

  @override
  $Res call({
    Object date = freezed,
    Object value = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed ? _value.date : date as DateTime,
      value: value == freezed ? _value.value : value as Rational,
    ));
  }
}

abstract class _$GenericProgressCopyWith<$Res>
    implements $GenericProgressCopyWith<$Res> {
  factory _$GenericProgressCopyWith(
          _GenericProgress value, $Res Function(_GenericProgress) then) =
      __$GenericProgressCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(required: true)
          DateTime date,
      @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
          Rational value});
}

class __$GenericProgressCopyWithImpl<$Res>
    extends _$GenericProgressCopyWithImpl<$Res>
    implements _$GenericProgressCopyWith<$Res> {
  __$GenericProgressCopyWithImpl(
      _GenericProgress _value, $Res Function(_GenericProgress) _then)
      : super(_value, (v) => _then(v as _GenericProgress));

  @override
  _GenericProgress get _value => super._value as _GenericProgress;

  @override
  $Res call({
    Object date = freezed,
    Object value = freezed,
  }) {
    return _then(_GenericProgress(
      date == freezed ? _value.date : date as DateTime,
      value == freezed ? _value.value : value as Rational,
    ));
  }
}

@JsonSerializable()
class _$_GenericProgress implements _GenericProgress {
  _$_GenericProgress(
      @JsonKey(required: true)
          this.date,
      @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
          this.value)
      : assert(date != null),
        assert(value != null);

  factory _$_GenericProgress.fromJson(Map<String, dynamic> json) =>
      _$_$_GenericProgressFromJson(json);

  @override
  @JsonKey(required: true)
  final DateTime date;
  @override
  @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
  final Rational value;

  @override
  String toString() {
    return 'GenericProgress(date: $date, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GenericProgress &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(value);

  @override
  _$GenericProgressCopyWith<_GenericProgress> get copyWith =>
      __$GenericProgressCopyWithImpl<_GenericProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GenericProgressToJson(this);
  }
}

abstract class _GenericProgress implements GenericProgress {
  factory _GenericProgress(
      @JsonKey(required: true)
          DateTime date,
      @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
          Rational value) = _$_GenericProgress;

  factory _GenericProgress.fromJson(Map<String, dynamic> json) =
      _$_GenericProgress.fromJson;

  @override
  @JsonKey(required: true)
  DateTime get date;
  @override
  @JsonKey(required: true, fromJson: rationalFromJson, toJson: rationalToJson)
  Rational get value;
  @override
  _$GenericProgressCopyWith<_GenericProgress> get copyWith;
}
