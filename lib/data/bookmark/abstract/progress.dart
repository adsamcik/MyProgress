/// <summary>
///     Progress update interface
/// </summary>
abstract class Progress {
  /// <summary>
  ///     Date of the progress update
  /// </summary>
  DateTime get date;

  /// <summary>
  ///     Progress value
  /// </summary>
  double get value;
}
