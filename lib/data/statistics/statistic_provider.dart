import 'package:MarkMyProgress/data/bookmark/abstract/bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/instance/generic_progress.dart';
import 'package:MarkMyProgress/data/runtime/pair.dart';
import 'package:MarkMyProgress/data/statistics/statistic_data.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:rational/rational.dart';

class StatisticProvider {
  final List<Bookmark> _bookmarks;
  List<List<GenericProgress>> _diffProgress;

  StatisticData _statisticData;

  StatisticData get statisticData => _statisticData;

  StatisticProvider(this._bookmarks);

  List<List<GenericProgress>> _generateDiffProgress() {
    var result = <List<GenericProgress>>[];
    for (var i = 0; i < _bookmarks.length; i++) {
      var lastValue = Rational.zero;
      result.add(_bookmarks[i].history.map((record) {
        var diff = record.value - lastValue;
        lastValue = record.value;
        return GenericProgress(record.date, diff);
      }).toList());
    }
    return result;
  }

  Future<void> _generateMonthlyProgress(MutableStatisticData data) async {
    var dailyReading = <DateTime, Rational>{};
    var maxDate = DateTime.now();
    var minDate = DateTime(maxDate.year - 1, maxDate.month, maxDate.day);

    _diffProgress.forEach((record) {
      record.where((element) => element.date.isAfter(minDate)).forEach((record) {
        var date = DateTime(record.date.year, record.date.month);
        if (dailyReading.containsKey(date)) {
          dailyReading[date] += record.value;
        } else {
          dailyReading[date] = record.value;
        }
      });
    });

    var now = DateTime.now();
    var nextDate = minDate;
    while (nextDate.isBefore(now)) {
      dailyReading.putIfAbsent(nextDate, () => Rational.zero);
      nextDate = DateTime(nextDate.year, nextDate.month + 1);
    }

    var result = dailyReading.entries.map((entry) => Pair(entry.key.difference(maxDate), entry.value)).toList();

    result.sort((a, b) => a.item1.compareTo(b.item1));

    data.monthlyProgress = result;
  }

  Future<void> _generateDayOfWeekLast90days(MutableStatisticData data) async {
    const dayOfWeekCount = 7;
    var dayCountList = List<Rational>(dayOfWeekCount);
    for (var i = 0; i < dayOfWeekCount; i++) {
      dayCountList[i] = Rational.zero;
    }

    var today = DateTime.now();
    var minDate = DateTime(today.year, today.month - 3, today.day);

    _diffProgress.forEach((record) {
      record.where((element) => element.date.isAfter(minDate)).forEach((record) {
        dayCountList[record.date.weekday - 1] += record.value;
      });
    });

    var result = List<Pair<Duration, Rational>>(dayOfWeekCount);
    for (var i = 0; i < dayOfWeekCount; i++) {
      result[i] = Pair(Duration(days: 8 - today.weekday + i), dayCountList[i]);
    }

    result.sort((a, b) => a.item1.compareTo(b.item1));

    data.dayOfWeekProgress = result;
  }

  Future<void> _generateDailyProgress(MutableStatisticData data) async {
    var dailyReading = <DateTime, Rational>{};
    var maxDate = DateTime.now();
    var minDate = DateTime(maxDate.year, maxDate.month - 1, maxDate.day);

    _diffProgress.forEach((record) {
      record.where((element) => element.date.isAfter(minDate)).forEach((record) {
        if (dailyReading.containsKey(record.date)) {
          dailyReading[record.date] += record.value;
        } else {
          dailyReading[record.date] = record.value;
        }
      });
    });

    var now = DateTime.now();
    const dayDuration = Duration(days: 1);
    var nextDate = DateTime(minDate.year, minDate.month, minDate.day);
    while (nextDate.isBefore(now)) {
      dailyReading.putIfAbsent(nextDate, () => Rational.zero);
      nextDate = nextDate.add(dayDuration);
    }

    var result = dailyReading.entries.map((entry) => Pair(entry.key.difference(maxDate), entry.value)).toList();

    result.sort((a, b) => a.item1.compareTo(b.item1));

    data.dailyProgress = result;
  }

  Future<void> _generateActiveCount(MutableStatisticData data) async {
    data.active = _bookmarks.fold<int>(0, (previousValue, element) {
      if (!element.abandoned && (element.ongoing || element.progress < element.maxProgress)) {
        return previousValue + 1;
      } else {
        return previousValue;
      }
    });
  }

  Future<void> _generateAvgPerDayLast30Days(MutableStatisticData data) async {
    var avg =
        data.dailyProgress.fold<Rational>(Rational.zero, (previousValue, element) => previousValue + element.item2);

    data.avgPerDayLast30Days = avg / Rational.fromInt(data.dailyProgress.length);
  }

  Future<StatisticData> generate() async {
    var result = MutableStatisticData();

    _diffProgress = _generateDiffProgress();

    await Future.wait([
      _generateActiveCount(result),
      _generateMonthlyProgress(result),
      _generateDailyProgress(result),
      _generateDayOfWeekLast90days(result),
    ]);

    await Future.wait([
      _generateAvgPerDayLast30Days(result),
    ]);

    _statisticData = result.copyWith();
    return statisticData;
  }
}
