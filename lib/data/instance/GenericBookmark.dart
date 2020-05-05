import 'package:MarkMyProgress/data/abstract/BaseBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IProgress.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:MarkMyProgress/extensions/DateExtension.dart';
import 'package:MarkMyProgress/extensions/StringExtensions.dart';
import 'package:fuzzy/bitap/bitap.dart';
import 'package:fuzzy/fuzzy.dart';
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

  bool _contains(String where, String what) {
    if (where.isNullOrEmpty) return false;

    var stripped = StringExtensions.stripString(where);
    return stripped.contains(what);
  }

  @override
  bool contains(String query) {
    return _contains(originalTitle, query) ||
        _contains(localizedTitle, query) ||
        _contains(webAddress, query);
  }
}
