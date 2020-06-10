// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'statistic_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$StatisticDataTearOff {
  const _$StatisticDataTearOff();

  _StatisticData call(
      {List<Pair<Duration, Rational>> dailyProgress, List<Pair<Duration, Rational>> monthlyProgress, int active}) {
    return _StatisticData(
      dailyProgress: dailyProgress,
      monthlyProgress: monthlyProgress,
      active: active,
    );
  }
}

// ignore: unused_element
const $StatisticData = _$StatisticDataTearOff();

mixin _$StatisticData {
  List<Pair<Duration, Rational>> get dailyProgress;
  List<Pair<Duration, Rational>> get monthlyProgress;
  int get active;

  $StatisticDataCopyWith<StatisticData> get copyWith;
}

abstract class $StatisticDataCopyWith<$Res> {
  factory $StatisticDataCopyWith(StatisticData value, $Res Function(StatisticData) then) =
      _$StatisticDataCopyWithImpl<$Res>;
  $Res call({List<Pair<Duration, Rational>> dailyProgress, List<Pair<Duration, Rational>> monthlyProgress, int active});
}

class _$StatisticDataCopyWithImpl<$Res> implements $StatisticDataCopyWith<$Res> {
  _$StatisticDataCopyWithImpl(this._value, this._then);

  final StatisticData _value;
  // ignore: unused_field
  final $Res Function(StatisticData) _then;

  @override
  $Res call({
    Object dailyProgress = freezed,
    Object monthlyProgress = freezed,
    Object active = freezed,
  }) {
    return _then(_value.copyWith(
      dailyProgress: dailyProgress == freezed ? _value.dailyProgress : dailyProgress as List<Pair<Duration, Rational>>,
      monthlyProgress:
          monthlyProgress == freezed ? _value.monthlyProgress : monthlyProgress as List<Pair<Duration, Rational>>,
      active: active == freezed ? _value.active : active as int,
    ));
  }
}

abstract class _$StatisticDataCopyWith<$Res> implements $StatisticDataCopyWith<$Res> {
  factory _$StatisticDataCopyWith(_StatisticData value, $Res Function(_StatisticData) then) =
      __$StatisticDataCopyWithImpl<$Res>;
  @override
  $Res call({List<Pair<Duration, Rational>> dailyProgress, List<Pair<Duration, Rational>> monthlyProgress, int active});
}

class __$StatisticDataCopyWithImpl<$Res> extends _$StatisticDataCopyWithImpl<$Res>
    implements _$StatisticDataCopyWith<$Res> {
  __$StatisticDataCopyWithImpl(_StatisticData _value, $Res Function(_StatisticData) _then)
      : super(_value, (v) => _then(v as _StatisticData));

  @override
  _StatisticData get _value => super._value as _StatisticData;

  @override
  $Res call({
    Object dailyProgress = freezed,
    Object monthlyProgress = freezed,
    Object active = freezed,
  }) {
    return _then(_StatisticData(
      dailyProgress: dailyProgress == freezed ? _value.dailyProgress : dailyProgress as List<Pair<Duration, Rational>>,
      monthlyProgress:
          monthlyProgress == freezed ? _value.monthlyProgress : monthlyProgress as List<Pair<Duration, Rational>>,
      active: active == freezed ? _value.active : active as int,
    ));
  }
}

class _$_StatisticData implements _StatisticData {
  _$_StatisticData({this.dailyProgress, this.monthlyProgress, this.active});

  @override
  final List<Pair<Duration, Rational>> dailyProgress;
  @override
  final List<Pair<Duration, Rational>> monthlyProgress;
  @override
  final int active;

  @override
  String toString() {
    return 'StatisticData(dailyProgress: $dailyProgress, monthlyProgress: $monthlyProgress, active: $active)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StatisticData &&
            (identical(other.dailyProgress, dailyProgress) ||
                const DeepCollectionEquality().equals(other.dailyProgress, dailyProgress)) &&
            (identical(other.monthlyProgress, monthlyProgress) ||
                const DeepCollectionEquality().equals(other.monthlyProgress, monthlyProgress)) &&
            (identical(other.active, active) || const DeepCollectionEquality().equals(other.active, active)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(dailyProgress) ^
      const DeepCollectionEquality().hash(monthlyProgress) ^
      const DeepCollectionEquality().hash(active);

  @override
  _$StatisticDataCopyWith<_StatisticData> get copyWith =>
      __$StatisticDataCopyWithImpl<_StatisticData>(this, _$identity);
}

abstract class _StatisticData implements StatisticData {
  factory _StatisticData(
      {List<Pair<Duration, Rational>> dailyProgress,
      List<Pair<Duration, Rational>> monthlyProgress,
      int active}) = _$_StatisticData;

  @override
  List<Pair<Duration, Rational>> get dailyProgress;
  @override
  List<Pair<Duration, Rational>> get monthlyProgress;
  @override
  int get active;
  @override
  _$StatisticDataCopyWith<_StatisticData> get copyWith;
}
