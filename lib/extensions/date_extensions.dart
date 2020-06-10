import 'package:intl/intl.dart';

extension Date on DateTime {
  static DateTime get invalid => DateTime(0);

  static DateTime get today => DateTime.now().toDate();

  DateTime toDate() => DateTime(year, month, day);

  DateTime get firstDayOfMonth => DateTime(year, month, 1, hour, minute, second, millisecond, microsecond);

  int get dayOfYear => int.parse(DateFormat('D').format(this));

  int get week {
    var dayOfYear = this.dayOfYear;
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  String toDateString() => DateFormat.yMMMd(Intl.getCurrentLocale()).format(this);

  String toMonthString() => DateFormat.MMMd(Intl.getCurrentLocale()).format(this);

  String toYearMonthString() => DateFormat.yMMM(Intl.getCurrentLocale()).format(this);
}
