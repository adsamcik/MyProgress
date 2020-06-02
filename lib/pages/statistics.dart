import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/database/data_store.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/generated/locale_keys.g.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Statistics extends StatefulWidget {
  Statistics({Key key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int _activelyReading = 0;

  Future<List<PersistentBookmark>> _loadDatabaseData() async {
    var store = GetIt.instance.get<DataStore>();
    await store.open();
    var records = await store.getAll().toList();
    await store.close();
    _recalculateData(records);
    return records;
  }

  void _recalculateData(List<PersistentBookmark> list) {
    _activelyReading = list.fold<int>(0, (previousValue, element) {
      if (!element.abandoned && (element.ongoing || element.progress < element.maxProgress)) {
        return previousValue + 1;
      } else {
        return previousValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.statistics.tr())),
        body: SafeArea(
            minimum: EdgeInsets.all(16.0),
            maintainBottomViewPadding: true,
            child: FutureBuilder<List<PersistentBookmark>>(
              future: _loadDatabaseData(),
              builder: (context, data) {
                if (data.hasData) {
                  return SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(LocaleKeys.statistics_item_count.plural(_activelyReading)),
                    StatisticsChart(data.data),
                  ]));
                }
                return Container();
              },
            )));
  }
}

class StatisticsChart extends StatefulWidget {
  final List<PersistentBookmark> _bookmarks;

  StatisticsChart(this._bookmarks);

  @override
  State<StatefulWidget> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  List<TimeSeriesCount> _dailyReadingData;

  @override
  void initState() {
    super.initState();

    var dailyReading = <DateTime, int>{};
    widget._bookmarks.forEach((bookmark) {
      bookmark.history.forEach((record) {
        if (dailyReading.containsKey(record.date)) {
          dailyReading[record.date] += 1;
        } else {
          dailyReading[record.date] = 1;
        }
      });
    });

    var minDate = dailyReading.keys.fold<DateTime>(
        DateTime.now(), (previousDate, thisDate) => thisDate.isBefore(previousDate) ? thisDate : previousDate);

    var now = DateTime.now();
    var nextDate = minDate.add(Duration(days: 1));
    while (nextDate.isBefore(now)) {
      dailyReading.putIfAbsent(nextDate, () => 0);
      nextDate = nextDate.add(Duration(days: 1));
    }

    var data = dailyReading.entries.map((entry) => TimeSeriesCount(entry.key, entry.value)).toList();

    data.sort((a, b) => a.date.compareTo(b.date));

    // todo handle initial import values in a better way
    data.removeAt(0);

    _dailyReadingData = data;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: TimeSeriesChart(
          [
            Series<TimeSeriesCount, DateTime>(
                id: 'DailyReading',
                data: _dailyReadingData,
                domainFn: (TimeSeriesCount datum, int index) => datum.date,
                measureFn: (TimeSeriesCount datum, int index) => datum.count),
          ],
        ));
  }
}

class TimeSeriesCount {
  final DateTime date;
  final int count;

  TimeSeriesCount(this.date, this.count);
}
