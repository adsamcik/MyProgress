import 'package:freezed_annotation/freezed_annotation.dart';

part 'PreferenceBlocEvent.freezed.dart';

@freezed
abstract class PreferenceBlocEvent with _$PreferenceBlocEvent {
  const factory PreferenceBlocEvent.load() = LoadPreferences;

  const factory PreferenceBlocEvent.set({
    @required String key,
    @required dynamic value,
  }) = Set;
}
