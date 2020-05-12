import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_bloc_state.freezed.dart';

@freezed
abstract class PreferenceBlocState with _$PreferenceBlocState {
  const factory PreferenceBlocState.notReady() = PreferencesNotReady;

  const factory PreferenceBlocState.ready({
    @required int version,
    @required Map<String, dynamic> preferences,
  }) = PreferencesReady;
}
