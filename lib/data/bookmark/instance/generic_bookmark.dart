import 'package:MarkMyProgress/data/bookmark/abstract/base_bookmark.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/progress.dart';
import 'package:MarkMyProgress/data/bookmark/abstract/web_bookmark.dart';
import 'package:MarkMyProgress/data/runtime/searchable_variable.dart';
import 'package:MarkMyProgress/extensions/date_extensions.dart';
import 'package:MarkMyProgress/extensions/string_extensions.dart';
import 'package:json_annotation/json_annotation.dart';

import 'generic_progress.dart';

part 'generic_bookmark.g.dart';

/// <summary>
///     Generic readable implementation for most reading materials.
/// </summary>
@JsonSerializable(explicitToJson: true)
class GenericBookmark extends BaseBookmark implements WebBookmark {
  GenericBookmark();

  @override
  Progress createNewProgress(double progress) {
    return GenericProgress(Date.today, progress);
  }

  @override
  String webAddress;

  factory GenericBookmark.fromJson(Map<String, dynamic> json) =>
      _$GenericBookmarkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenericBookmarkToJson(this);

  // todo update so that it cannot be change from the outside
  @JsonKey(name: 'history')
  List<GenericProgress> history_generic = [];

  @override
  List<Progress> get history => history_generic;

  @override
  double get progressIncrement => super.progressIncrement ?? 1.0;

  @override
  Iterable<SearchableVariable> get searchList => [
        SearchableVariable(localizedTitle, 1),
        SearchableVariable(
            originalTitle, localizedTitle.isNullOrEmpty ? 1 : 0.99),
        SearchableVariable(webAddress, 0.9)
      ];
}
