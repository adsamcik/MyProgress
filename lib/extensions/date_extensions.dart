import 'package:intl/intl.dart';

extension Date on DateTime {
  static DateTime get invalid => DateTime(0);

  static DateTime get today => DateTime.now().toDate();

  DateTime toDate() => DateTime(year, month, day);

  String toDateString() => DateFormat.yMMMd(Intl.getCurrentLocale()).format(this);
}
