import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:myprogress/constants/numbers.dart';
import 'package:myprogress/data/runtime/pair.dart';
import 'package:myprogress/extensions/number.dart';
import 'package:rational/rational.dart';

class StatisticDurationChart extends StatefulWidget {
  final List<Pair<Duration, Rational>> _data;
  final double interval;
  final String Function(DateTime dateTime) dateTimeFormat;

  StatisticDurationChart(this._data, {this.interval, this.dateTimeFormat});

  @override
  State<StatefulWidget> createState() => _StatisticDurationChartState();
}

class _StatisticDurationChartState extends State<StatisticDurationChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
        child: LineChart(data()),
      ),
    );
  }

  static const List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];

  LineChartData data() {
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
      minY: 0,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: widget.interval,
          textStyle: const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            return widget.dateTimeFormat(now.add(Duration(days: value.toInt())));
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
          interval: max(
              widget._data.fold<double>(0.0, (previousValue, element) => max(previousValue, element.item2.toDouble())) /
                  10.0,
              1),
          getTitles: (value) {
            return value.toPrecision(standardPrecision).toString();
          },
          reservedSize: 54,
          margin: 16,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: widget._data
              .map((e) => FlSpot(e.item1.inDays.toDouble(), e.item2.toDouble().toPrecision(standardPrecision)))
              .toList(),
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
