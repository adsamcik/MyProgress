import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';

class NoProgress implements Progress {
  @override
  DateTime get date => Date.invalid;

  @override
  double get value => 0.0;
}
