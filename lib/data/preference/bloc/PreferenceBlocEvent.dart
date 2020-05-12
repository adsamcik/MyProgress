import 'package:MarkMyProgress/data/bookmark/filter/filter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PreferenceBlocEvent.freezed.dart';

@freezed
abstract class PreferenceBlocEvent with _$PreferenceBlocEvent {
  const factory PreferenceBlocEvent.load() = LoadPreferences;

  const factory PreferenceBlocEvent.setPreference({
    @required String key,
    @required dynamic value,
  }) = SetPreference;

  const factory PreferenceBlocEvent.updateFilterData(
      {@required FilterData data}) = UpdateFilterData;
}
