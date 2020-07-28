// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'statistic_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$StatisticDataTearOff {
  const _$StatisticDataTearOff();

// ignore: unused_element
  _StatisticData call(
      {List<Pair<Duration, Rational>> dailyProgress,
      List<Pair<Duration, Rational>> monthlyProgress,
      List<Pair<Duration, Rational>> dayOfWeekProgress,
      int active,
      Rational avgPerDayLast30Days}) {
    return _StatisticData(
      dailyProgress: dailyProgress,
      monthlyProgress: monthlyProgress,
      dayOfWeekProgress: dayOfWeekProgress,
      active: active,
      avgPerDayLast30Days: avgPerDayLast30Days,
    );
  }
}

// ignore: unused_element
const $StatisticData = _$StatisticDataTearOff();

mixin _$StatisticData {
  List<Pair<Duration, Rational>> get dailyProgress;
  List<Pair<Duration, Rational>> get monthlyProgress;
  List<Pair<Duration, Rational>> get dayOfWeekProgress;
  int get active;
  Rational get avgPerDayLast30Days;

  $StatisticDataCopyWith<StatisticData> get copyWith;
}

abstract class $StatisticDataCopyWith<$Res> {
  factory $StatisticDataCopyWith(
          StatisticData value, $Res Function(StatisticData) then) =
      _$StatisticDataCopyWithImpl<$Res>;
  $Res call(
      {List<Pair<Duration, Rational>> dailyProgress,
      List<Pair<Duration, Rational>> monthlyProgress,
      List<Pair<Duration, Rational>> dayOfWeekProgress,
      int active,
      Rational avgPerDayLast30Days});
}

class _$StatisticDataCopyWithImpl<$Res>
    implements $StatisticDataCopyWith<$Res> {
  _$StatisticDataCopyWithImpl(this._value, this._then);

  final StatisticData _value;
  // ignore: unused_field
  final $Res Function(StatisticData) _then;

  @override
  $Res call({
    Object dailyProgress = freezed,
    Object monthlyProgress = freezed,
    Object dayOfWeekProgress = freezed,
    Object active = freezed,
    Object avgPerDayLast30Days = freezed,
  }) {
    return _then(_value.copyWith(
      dailyProgress: dailyProgress == freezed
          ? _value.dailyProgress
          : dailyProgress as List<Pair<Duration, Rational>>,
      monthlyProgress: monthlyProgress == freezed
          ? _value.monthlyProgress
          : monthlyProgress as List<Pair<Duration, Rational>>,
      dayOfWeekProgress: dayOfWeekProgress == freezed
          ? _value.dayOfWeekProgress
          : dayOfWeekProgress as List<Pair<Duration, Rational>>,
      active: active == freezed ? _value.active : active as int,
      avgPerDayLast30Days: avgPerDayLast30Days == freezed
          ? _value.avgPerDayLast30Days
          : avgPerDayLast30Days as Rational,
    ));
  }
}

abstract class _$StatisticDataCopyWith<$Res>
    implements $StatisticDataCopyWith<$Res> {
  factory _$StatisticDataCopyWith(
          _StatisticData value, $Res Function(_StatisticData) then) =
      __$StatisticDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Pair<Duration, Rational>> dailyProgress,
      List<Pair<Duration, Rational>> monthlyProgress,
      List<Pair<Duration, Rational>> dayOfWeekProgress,
      int active,
      Rational avgPerDayLast30Days});
}

class __$StatisticDataCopyWithImpl<$Res>
    extends _$StatisticDataCopyWithImpl<$Res>
    implements _$StatisticDataCopyWith<$Res> {
  __$StatisticDataCopyWithImpl(
      _StatisticData _value, $Res Function(_StatisticData) _then)
      : super(_value, (v) => _then(v as _StatisticData));

  @override
  _StatisticData get _value => super._value as _StatisticData;

  @override
  $Res call({
    Object dailyProgress = freezed,
    Object monthlyProgress = freezed,
    Object dayOfWeekProgress = freezed,
    Object active = freezed,
    Object avgPerDayLast30Days = freezed,
  }) {
    return _then(_StatisticData(
      dailyProgress: dailyProgress == freezed
          ? _value.dailyProgress
          : dailyProgress as List<Pair<Duration, Rational>>,
      monthlyProgress: monthlyProgress == freezed
          ? _value.monthlyProgress
          : monthlyProgress as List<Pair<Duration, Rational>>,
      dayOfWeekProgress: dayOfWeekProgress == freezed
          ? _value.dayOfWeekProgress
          : dayOfWeekProgress as List<Pair<Duration, Rational>>,
      active: active == freezed ? _value.active : active as int,
      avgPerDayLast30Days: avgPerDayLast30Days == freezed
          ? _value.avgPerDayLast30Days
          : avgPerDayLast30Days as Rational,
    ));
  }
}

class _$_StatisticData implements _StatisticData {
  _$_StatisticData(
      {this.dailyProgress,
      this.monthlyProgress,
      this.dayOfWeekProgress,
      this.active,
      this.avgPerDayLast30Days});

  @override
  final List<Pair<Duration, Rational>> dailyProgress;
  @override
  final List<Pair<Duration, Rational>> monthlyProgress;
  @override
  final List<Pair<Duration, Rational>> dayOfWeekProgress;
  @override
  final int active;
  @override
  final Rational avgPerDayLast30Days;

  @override
  String toString() {
    return 'StatisticData(dailyProgress: $dailyProgress, monthlyProgress: $monthlyProgress, dayOfWeekProgress: $dayOfWeekProgress, active: $active, avgPerDayLast30Days: $avgPerDayLast30Days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StatisticData &&
            (identical(other.dailyProgress, dailyProgress) ||
                const DeepCollectionEquality()
                    .equals(other.dailyProgress, dailyProgress)) &&
            (identical(other.monthlyProgress, monthlyProgress) ||
                const DeepCollectionEquality()
                    .equals(other.monthlyProgress, monthlyProgress)) &&
            (identical(other.dayOfWeekProgress, dayOfWeekProgress) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfWeekProgress, dayOfWeekProgress)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.avgPerDayLast30Days, avgPerDayLast30Days) ||
                const DeepCollectionEquality()
                    .equals(other.avgPerDayLast30Days, avgPerDayLast30Days)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(dailyProgress) ^
      const DeepCollectionEquality().hash(monthlyProgress) ^
      const DeepCollectionEquality().hash(dayOfWeekProgress) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(avgPerDayLast30Days);

  @override
  _$StatisticDataCopyWith<_StatisticData> get copyWith =>
      __$StatisticDataCopyWithImpl<_StatisticData>(this, _$identity);
}

abstract class _StatisticData implements StatisticData {
  factory _StatisticData(
      {List<Pair<Duration, Rational>> dailyProgress,
      List<Pair<Duration, Rational>> monthlyProgress,
      List<Pair<Duration, Rational>> dayOfWeekProgress,
      int active,
      Rational avgPerDayLast30Days}) = _$_StatisticData;

  @override
  List<Pair<Duration, Rational>> get dailyProgress;
  @override
  List<Pair<Duration, Rational>> get monthlyProgress;
  @override
  List<Pair<Duration, Rational>> get dayOfWeekProgress;
  @override
  int get active;
  @override
  Rational get avgPerDayLast30Days;
  @override
  _$StatisticDataCopyWith<_StatisticData> get copyWith;
}
