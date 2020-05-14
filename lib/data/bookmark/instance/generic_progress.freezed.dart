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

  _GenericProgress call(DateTime date, double value) {
    return _GenericProgress(
      date,
      value,
    );
  }
}

// ignore: unused_element
const $GenericProgress = _$GenericProgressTearOff();

mixin _$GenericProgress {
  DateTime get date;
  double get value;

  Map<String, dynamic> toJson();
  $GenericProgressCopyWith<GenericProgress> get copyWith;
}

abstract class $GenericProgressCopyWith<$Res> {
  factory $GenericProgressCopyWith(
          GenericProgress value, $Res Function(GenericProgress) then) =
      _$GenericProgressCopyWithImpl<$Res>;
  $Res call({DateTime date, double value});
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
      value: value == freezed ? _value.value : value as double,
    ));
  }
}

abstract class _$GenericProgressCopyWith<$Res>
    implements $GenericProgressCopyWith<$Res> {
  factory _$GenericProgressCopyWith(
          _GenericProgress value, $Res Function(_GenericProgress) then) =
      __$GenericProgressCopyWithImpl<$Res>;
  @override
  $Res call({DateTime date, double value});
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
      value == freezed ? _value.value : value as double,
    ));
  }
}

@JsonSerializable()
class _$_GenericProgress implements _GenericProgress {
  _$_GenericProgress(this.date, this.value)
      : assert(date != null),
        assert(value != null);

  factory _$_GenericProgress.fromJson(Map<String, dynamic> json) =>
      _$_$_GenericProgressFromJson(json);

  @override
  final DateTime date;
  @override
  final double value;

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
  factory _GenericProgress(DateTime date, double value) = _$_GenericProgress;

  factory _GenericProgress.fromJson(Map<String, dynamic> json) =
      _$_GenericProgress.fromJson;

  @override
  DateTime get date;
  @override
  double get value;
  @override
  _$GenericProgressCopyWith<_GenericProgress> get copyWith;
}
