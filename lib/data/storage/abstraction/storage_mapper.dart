/// Class for converting to and from database types
abstract class StorageMapper<InstanceType, DatabaseType> {
  /// Converts value from database format
  InstanceType fromDatabase(DatabaseType value);

  /// Converts value to database format
  DatabaseType toDatabase(InstanceType value);
}
