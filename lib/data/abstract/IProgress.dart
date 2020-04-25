/// <summary>
///     Progress update interface
/// </summary>
abstract class IProgress {
  /// <summary>
  ///     Date of the progress update
  /// </summary>
  DateTime Date;

  /// <summary>
  ///     Progress value
  /// </summary>
  double Value;
}
