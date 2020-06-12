import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:markmyprogress/data/bookmark/filter/filter_data.dart';

part 'preference_bloc_event.freezed.dart';

@freezed
abstract class PreferenceBlocEvent with _$PreferenceBlocEvent {
  const factory PreferenceBlocEvent.load() = LoadPreferences;

  const factory PreferenceBlocEvent.setPreference({
    @required String key,
    @required dynamic value,
  }) = SetPreference;

  const factory PreferenceBlocEvent.updateFilterData({@required FilterData data}) = UpdateFilterData;
}
