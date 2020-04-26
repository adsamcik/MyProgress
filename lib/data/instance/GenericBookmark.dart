import 'package:MarkMyProgress/data/abstract/BaseBookmark.dart';
import 'package:MarkMyProgress/data/abstract/IProgress.dart';
import 'package:MarkMyProgress/data/abstract/IWebBookmark.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GenericProgress.dart';

part 'GenericBookmark.g.dart';

/// <summary>
///     Generic readable implementation for most reading materials.
/// </summary>
@JsonSerializable()
class GenericBookmark extends BaseBookmark implements IWebBookmark {
  GenericBookmark();

  @override
  IProgress CreateNewProgress(double progress) {
    return GenericProgress(DateTime.now(), progress);
  }

  @override
  String WebAddress;

  factory GenericBookmark.fromJson(Map<String, dynamic> json) => _$GenericBookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$GenericBookmarkToJson(this);

  // todo update so that it cannot be change from the outside
  List<GenericProgress> history = [];

  @override
  List<IProgress> get History => _history;
}
