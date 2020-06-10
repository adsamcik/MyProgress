import 'dart:math';

import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/database/data_store.dart';
import 'package:MarkMyProgress/data/runtime/pair.dart';
import 'package:MarkMyProgress/data/statistics/statistic_data.dart';
import 'package:MarkMyProgress/data/statistics/statistic_provider.dart';
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
  StatisticProvider _provider;

  Future<List<PersistentBookmark>> _loadDatabaseData() async {
    var store = GetIt.instance.get<DataStore>();
    await store.open();
    var records = await store.getAll().toList();
    await store.close();
    return records;
  }

  Widget _loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  List<Widget> _statisticChildren(StatisticData data) {
    return [
      Text(LocaleKeys.statistics_item_count.plural(data.active)),
      LastMonthChart(
        data.monthlyProgress,
        interval: 30.42,
      ),
      LastMonthChart(
        data.dailyProgress,
        interval: 7,
      ),
    ];
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
                  _provider = StatisticProvider(data.data);
                  return SingleChildScrollView(
                      child: FutureBuilder(
                    future: _provider.generate(),
                    builder: (BuildContext context, AsyncSnapshot<StatisticData> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start, children: _statisticChildren(snapshot.data));
                      } else if (snapshot.hasError) {
                        throw snapshot.error;
                      } else {
                        return _loadingWidget();
                      }
                    },
                  ));
                }
                return _loadingWidget();
              },
            )));
  }
}

class LastMonthChart extends StatefulWidget {
  final List<Pair<Duration, Rational>> _data;
  final double interval;

  LastMonthChart(this._data, {this.interval});

  @override
  State<StatefulWidget> createState() => _LastMonthChartState();
}

class _LastMonthChartState extends State<LastMonthChart> {
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
          interval: widget.interval,
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
          interval:
              widget._data.fold<double>(0.0, (previousValue, element) => max(previousValue, element.item2.toDouble())) /
                  10.0,
          getTitles: (value) {
            return value.toStringAsFixed(0);
          },
          reservedSize: 36,
          margin: 16,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: widget._data.map((e) => FlSpot(e.item1.inDays.toDouble(), e.item2.toDouble())).toList(),
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
