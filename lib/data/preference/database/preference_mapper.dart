import 'package:MarkMyProgress/data/preference/database/preference.dart';
import 'package:MarkMyProgress/data/storage/abstraction/storage_mapper.dart';

class PreferenceMapper implements StorageMapper<Preference, Map<String, dynamic>> {
  @override
  Preference fromDatabase(value) {
    return Preference.fromJson(value);
  }

  @override
  Map<String, dynamic> toDatabase(value) {
    return value.toJson();
  }
}
