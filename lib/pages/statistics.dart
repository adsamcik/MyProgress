import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/database/data_store.dart';
import 'package:MarkMyProgress/data/runtime/pair.dart';
import 'package:MarkMyProgress/extensions/bookmark_extensions.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:MarkMyProgress/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rational/rational.dart';

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
                    LastMonthChart(data.data),
                  ]));
                }
                return Container();
              },
            )));
  }
}

class LastMonthChart extends StatefulWidget {
  final List<PersistentBookmark> _bookmarks;

  LastMonthChart(this._bookmarks);

  @override
  State<StatefulWidget> createState() => _LastMonthChartState();
}

class _LastMonthChartState extends State<LastMonthChart> {
  List<Pair<Duration, Rational>> _dailyReadingData;

  @override
  void initState() {
    super.initState();

    var dailyReading = <DateTime, Rational>{};
    var maxDate = DateTime.now();
    var minDate = DateTime(maxDate.year, maxDate.month - 1, maxDate.day);

    widget._bookmarks.forEach((bookmark) {
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

    var data = dailyReading.entries.map((entry) => Pair(entry.key.difference(maxDate), entry.value)).toList();

    data.sort((a, b) => a.item1.compareTo(b.item1));

    _dailyReadingData = data;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
        child: LineChart(mainData()),
      ),
    );
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartData mainData() {
    var now = DateTime.now();
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 7,
          textStyle: const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            return now.subtract(Duration(days: value.toInt())).toMonthString();
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return value.toStringAsFixed(0);
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: _dailyReadingData.map((e) => FlSpot(e.item1.inDays.toDouble(), e.item2.toDouble())).toList(),
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
