/// <summary>
///     Progress update interface
/// </summary>
abstract class IProgress {
  /// <summary>
  ///     Date of the progress update
  /// </summary>
  DateTime date;

  /// <summary>
  ///     Progress value
  /// </summary>
  double value;
}
