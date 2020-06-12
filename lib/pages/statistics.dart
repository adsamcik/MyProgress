import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:markmyprogress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:markmyprogress/data/bookmark/database/data_store.dart';
import 'package:markmyprogress/data/statistics/statistic_data.dart';
import 'package:markmyprogress/data/statistics/statistic_provider.dart';
import 'package:markmyprogress/extensions/date_extensions.dart';
import 'package:markmyprogress/generated/locale_keys.g.dart';
import 'package:markmyprogress/widgets/data_card.dart';
import 'package:markmyprogress/widgets/statistic_duration_chart.dart';

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

  Widget _chart({@required String titleKey, @required Widget chart}) => Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                titleKey.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
              chart,
            ],
          ),
        ),
      );

  List<Widget> _statisticChildren(StatisticData data) {
    const minWidth = 32 * 20;
    var width = MediaQuery.of(context).size.width;

    var useLong = width >= minWidth;

    return [
      DataCard(
        rows: [
          CardRow(
            title: LocaleKeys.statistics_active_item_title.tr(),
            value: data.active.toString(),
          ),
          CardRow(
            title: LocaleKeys.statistics_avg_day_last_month_title.tr(),
            value: data.avgPerDayLast30Days.toDecimalString(),
          ),
        ],
      ),
      _chart(
        titleKey: LocaleKeys.statistics_weekday_title,
        chart: StatisticDurationChart(
          data.dayOfWeekProgress,
          interval: 1,
          dateTimeFormat: (dateTime) => useLong ? dateTime.toWeekdayString() : dateTime.toShortWeekdayString(),
        ),
      ),
      _chart(
        titleKey: LocaleKeys.statistics_daily_month_title,
        chart: StatisticDurationChart(
          data.dailyProgress,
          interval: 7,
          dateTimeFormat: (dateTime) => useLong ? dateTime.toMonthString() : dateTime.toShortMonthString(),
        ),
      ),
      _chart(
        titleKey: LocaleKeys.statistics_monthly_year_title,
        chart: StatisticDurationChart(
          data.monthlyProgress,
          interval: 30.42 / min(width / (32 * 40), 1),
          dateTimeFormat: (dateTime) => useLong ? dateTime.toYearMonthString() : dateTime.toShortYearMonthString(),
        ),
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
