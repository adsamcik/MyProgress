import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';

class NoProgress implements Progress {
  @override
  DateTime get date => Date.invalid;

  @override
  double get value => 0.0;

  @override
  set date(DateTime _date) {
    throw StateError('Date cannot be set NoProgress instance.');
  }

  @override
  set value(double _value) {
    throw StateError('Value cannot be set on NoProgress instance.');
  }
}
