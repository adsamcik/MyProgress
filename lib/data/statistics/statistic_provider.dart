import 'package:MarkMyProgress/data/bookmark/abstract/bookmark.dart';
import 'package:MarkMyProgress/data/runtime/pair.dart';
import 'package:MarkMyProgress/data/statistics/statistic_data.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:rational/rational.dart';

class StatisticProvider {
  final List<Bookmark> _bookmarks;

  StatisticData _statisticData;

  StatisticData get statisticData => _statisticData;

  StatisticProvider(this._bookmarks);

  Future<void> _generateDailyProgress(MutableStatisticData data) async {
    var dailyReading = <DateTime, Rational>{};
    var maxDate = DateTime.now();
    var minDate = DateTime(maxDate.year, maxDate.month - 1, maxDate.day);

    _bookmarks.forEach((bookmark) {
      var lastValue = Rational.zero;
      bookmark.history.where((element) => element.date.isAfter(minDate)).forEach((record) {
        var diff = record.value - lastValue;
        if (dailyReading.containsKey(record.date)) {
          dailyReading[record.date] += diff;
        } else {
          dailyReading[record.date] = diff;
        }
        lastValue = record.value;
      });
    });

    var now = DateTime.now();
    const dayDuration = Duration(days: 1);
    var nextDate = minDate.add(dayDuration);
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

  Future<StatisticData> generate() async {
    var futures = <Future<void>>[];
    var result = MutableStatisticData();
    futures.add(_generateDailyProgress(result));
    futures.add(_generateActiveCount(result));

    await Future.wait(futures);

    _statisticData = result.copyWith();
    return statisticData;
  }
}
