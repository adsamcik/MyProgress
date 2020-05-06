import 'dart:math';

import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/runtime/SearchableVariable.dart';
import 'package:edit_distance/edit_distance.dart';

class SearchableBookmark {
  static const int _threshold = 3;

  final IPersistentBookmark bookmark;
  List<SearchableVariable> _variables;

  SearchableBookmark(this.bookmark) {
    _variables = bookmark.searchList.toList(growable: false);
    _variables.sort((a, b) {
      if (a.priority > b.priority) {
        return 1;
      } else if (a.priority < b.priority) {
        return -1;
      } else {
        return 0;
      }
    });
  }

  double _match(String query, String resultSubstr) {
    var distance = Levenshtein().distance(query, resultSubstr);
    return distance < _threshold
        ? 1 - distance.toDouble() / _threshold.toDouble()
        : 0;
  }

  List<String> _generateSubstringList(String value, int queryLength) {
    if (value.length <= queryLength) {
      return [value];
    } else {
      var lengthDiff = value.length - queryLength;
      var result = List<String>(lengthDiff);
      for (var i = 0; i < lengthDiff; i++) {
        result[i] = value.substring(i, i + queryLength);
      }
      return result;
    }
  }

  double bestMatch(String query) {
    return _variables.fold<double>(0.0, (previousValue, e) {
      var matchValue = 0.0;
      if (e.strippedValue == null) {
        return 0;
      } else if (e.strippedValue.contains(query)) {
        matchValue = 1.0;
      } else {
        matchValue = _generateSubstringList(e.value, query.length)
            .fold<double>(
                0.0,
                (previousValue, substring) =>
                    max(previousValue, _match(query, substring)));
      }
      return max(previousValue, matchValue * e.priority);
    });
  }
}
