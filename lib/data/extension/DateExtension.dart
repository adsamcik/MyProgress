import 'package:intl/intl.dart';

extension Date on DateTime {
  static DateTime today() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  String toDateString() => DateFormat.yMMMd(Intl.getCurrentLocale()).format(this);
}
