import 'package:MarkMyProgress/data/bookmark/filter/FilterData.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PreferenceBlocState.freezed.dart';

@freezed
abstract class PreferenceBlocState with _$PreferenceBlocState {
  const factory PreferenceBlocState.notReady() = PreferencesNotReady;

  const factory PreferenceBlocState.ready({
    @required int version,
    @required Map<String, dynamic> preferences,
  }) = PreferencesReady;

  const factory PreferenceBlocState.updateFilterData(
      {@required FilterData data}) = UpdateFilterData;
}
