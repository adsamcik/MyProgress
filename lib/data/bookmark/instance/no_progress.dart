import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:rational/rational.dart';

class NoProgress implements Progress {
  @override
  DateTime get date => Date.invalid;

  @override
  Rational get value => Rational.zero;
}
