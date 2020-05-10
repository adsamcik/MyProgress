import 'package:MarkMyProgress/data/storage/abstraction/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference.freezed.dart';
part 'preference.g.dart';

@freezed
abstract class Preference with _$Preference implements Storable<String> {
  factory Preference({@required String key}) = _Preference;

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);
}
