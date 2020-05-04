import 'package:intl/intl.dart';

extension Date on DateTime {
  static DateTime invalid() => DateTime(0);

  static DateTime today() => DateTime.now().toDate();

  DateTime toDate() => DateTime(year, month, day);

  String toDateString() =>
      DateFormat.yMMMd(Intl.getCurrentLocale()).format(this);
}
