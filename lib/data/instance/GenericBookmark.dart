import 'package:MarkMyProgress/data/abstract/BaseBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IProgress.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/data/runtime/SearchableVariable.dart';
import 'package:MarkMyProgress/extensions/DateExtension.dart';
import 'package:MarkMyProgress/extensions/StringExtensions.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GenericProgress.dart';

part 'GenericBookmark.g.dart';

/// <summary>
///     Generic readable implementation for most reading materials.
/// </summary>
@JsonSerializable(explicitToJson: true)
class GenericBookmark extends BaseBookmark implements IWebBookmark {
  GenericBookmark();

  @override
  IProgress createNewProgress(double progress) {
    return GenericProgress(Date.today(), progress);
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
  List<IProgress> get history => history_generic;

  @override
  double get progressIncrement => super.progressIncrement ?? 1.0;

  @override
  Iterable<SearchableVariable> get searchList => [
        SearchableVariable(localizedTitle, 1),
        SearchableVariable(originalTitle, localizedTitle.isNullOrEmpty ? 1 : 0.99),
        SearchableVariable(webAddress, 0.9)
      ];
}
