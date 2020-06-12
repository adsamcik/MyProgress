import 'package:markmyprogress/data/preference/database/preference.dart';
import 'package:markmyprogress/data/storage/abstraction/storage_mapper.dart';

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
