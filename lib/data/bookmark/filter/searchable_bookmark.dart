import 'dart:math';

import 'package:MarkMyProgress/data/bookmark/abstract/persistent_bookmark.dart';
import 'package:MarkMyProgress/data/runtime/MatchResult.dart';
import 'package:MarkMyProgress/data/runtime/SearchableVariable.dart';
import 'package:MarkMyProgress/extensions/string_extensions.dart';
import 'package:edit_distance/edit_distance.dart';

class SearchableBookmark {
  final PersistentBookmark bookmark;
  List<SearchableVariable> _variableList;

  List<SearchableVariable> get variableList {
    if (_variableList == null) {
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
    return 1 - JaroWinkler().normalizedDistance(query, resultSubstr);
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
    return variableList.fold<MatchResult>(MatchResult(0, 0),
        (previousValue, e) {
      if (e.strippedValue.isNullOrEmpty) {
        return previousValue;
      }

      var matchValue = 0.0;
      if (e.strippedValue.contains(query)) {
        matchValue = 1.0;
      } else {
        matchValue = _generateSubstringList(e.strippedValue, query.length)
            .fold<double>(
                0.0,
                (previousValue, substring) =>
                    max(previousValue, _match(query, substring)));
      }

      if (previousValue.priority * previousValue.match >=
          matchValue * e.priority) {
        return previousValue;
      } else {
        return MatchResult(e.priority, matchValue);
      }
    });
  }
}
