import 'dart:math';

import 'package:MarkMyProgress/data/abstract/IPersistentBookmark.dart';
import 'package:MarkMyProgress/data/runtime/MatchResult.dart';
import 'package:MarkMyProgress/data/runtime/SearchableVariable.dart';
import 'package:edit_distance/edit_distance.dart';

class SearchableBookmark {
  static const int _distanceThreshold = 3;

  final IPersistentBookmark bookmark;
  List<SearchableVariable> _variableList;

  List<SearchableVariable> get variableList {
    if (variableList == null) {
      _initializeCache();
    }
    return _variableList;
  }

  SearchableBookmark(this.bookmark);

  void _initializeCache() {
    _variableList = bookmark.searchList.toList(growable: false);
    _variableList.sort((a, b) {
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
    return distance < _distanceThreshold
        ? 1 - distance.toDouble() / _distanceThreshold.toDouble()
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

  MatchResult bestMatch(String query) {
    return variableList.fold<MatchResult>(MatchResult(0, 0), (previousValue, e) {
      var matchValue = 0.0;
      if (e.strippedValue == null) {
        return previousValue;
      } else if (e.strippedValue.contains(query)) {
        matchValue = 1.0;
      } else {
        matchValue = _generateSubstringList(e.value, query.length).fold<double>(
            0.0,
            (previousValue, substring) =>
                max(previousValue, _match(query, substring)));
      }

      if (previousValue.priority * previousValue.match >
          matchValue * e.priority) {
        return previousValue;
      } else {
        return MatchResult(e.priority, matchValue);
      }
    });
  }
}
