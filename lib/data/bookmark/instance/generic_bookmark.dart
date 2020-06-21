import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myprogress/data/bookmark/abstract/base_bookmark.dart';
import 'package:myprogress/data/bookmark/abstract/progress.dart';
import 'package:myprogress/data/bookmark/abstract/web_bookmark.dart';
import 'package:myprogress/data/runtime/searchable_variable.dart';
import 'package:myprogress/extensions/date.dart';
import 'package:myprogress/extensions/string.dart';
import 'package:myprogress/misc/rational.dart';
import 'package:rational/rational.dart';

import 'generic_progress.dart';

part 'generic_bookmark.g.dart';

/// <summary>
///     Generic readable implementation for most reading materials.
/// </summary>
@JsonSerializable(explicitToJson: true)
class GenericBookmark extends BaseBookmark implements WebBookmark {
  GenericBookmark();

  @override
  Progress createNewProgress(Rational progress) {
    return GenericProgress(Date.today, progress);
  }

  @override
  String webAddress;

  factory GenericBookmark.fromJson(Map<String, dynamic> json) => _$GenericBookmarkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenericBookmarkToJson(this);

  // todo update so that it cannot be change from the outside
  @JsonKey(name: 'history')
  List<GenericProgress> history_generic = [];

  @override
  List<Progress> get history => history_generic;

  @override
  Rational get progressIncrement => super.progressIncrement ?? Rational.one;

  @override
  Iterable<SearchableVariable> get searchList => [
        SearchableVariable(localizedTitle, 1),
        SearchableVariable(originalTitle, localizedTitle.isNullOrEmpty ? 1 : 0.99),
        SearchableVariable(webAddress, 0.9)
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is GenericBookmark &&
          runtimeType == other.runtimeType &&
          webAddress == other.webAddress &&
          listEquals(history, other.history);

  @override
  int get hashCode => super.hashCode ^ webAddress.hashCode ^ history_generic.hashCode;
}
