/// <summary>
///     Determines object item. This allows generic methods to work with database items.
/// </summary>
abstract class IDatabaseItem {
  int id;

  Map<String, dynamic> toJson();
}
