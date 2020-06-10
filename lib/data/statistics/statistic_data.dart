import 'package:MarkMyProgress/data/runtime/pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rational/rational.dart';

part 'statistic_data.freezed.dart';

@freezed
abstract class StatisticData with _$StatisticData {
  factory StatisticData({
    List<Pair<Duration, Rational>> dailyProgress,
    int active,
  }) = _StatisticData;
}

class MutableStatisticData implements _StatisticData {
  @override
  List<Pair<Duration, Rational>> dailyProgress;

  @override
  int active;

  @override
  _$StatisticDataCopyWith<_StatisticData> get copyWith =>
      __$StatisticDataCopyWithImpl<_StatisticData>(this, _$identity);
}
