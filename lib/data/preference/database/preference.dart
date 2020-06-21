import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myprogress/data/storage/abstraction/storable.dart';

part 'preference.g.dart';

@JsonSerializable()
class Preference implements Storable<String> {
  @override
  String key;

  dynamic value;

  Preference(
    this.key,
    this.value,
  );

  MapEntry<String, dynamic> toMapEntry() => MapEntry<String, dynamic>(key, value);

  factory Preference.fromJson(Map<String, dynamic> json) => _$PreferenceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference && runtimeType == other.runtimeType && key == other.key && value == other.value);

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'Preference{key: $key, value: $value,}';
  }

  Preference copyWith({
    String key,
    dynamic value,
  }) {
    return Preference(
      key ?? this.key,
      value ?? this.value,
    );
  }

//</editor-fold>
}
