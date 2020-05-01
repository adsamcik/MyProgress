import 'package:sembast/sembast.dart';

/// <summary>
///     Interface specifying conversion action. This converts database from older format to newer format.
/// </summary>
abstract class IConversion {
  /// <summary>
  ///     Convert method converting database from old format to new format.
  /// </summary>
  /// <param name="database">Database instance</param>
  void convert(Database database);
}
