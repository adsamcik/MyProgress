extension ListExtensions<T> on List<T> {
  /// Returns list of items that correspond to indexes in [indexes] parameter.
  List<T> filterWithIndexList(List<int> indexes) {
    var list = List<T>(indexes.length);
    for (var i = 0; i < indexes.length; i++) {
      list[i] = this[indexes[i]];
    }
    return list;
  }

  /// Maps non-null items to new list
  List<K> mapNotNull<K>(K Function(T e) mapFunction) {
    var result = <K>[];
    forEach((element) {
      if (element != null) {
        result.add(mapFunction(element));
      }
    });
    return result;
  }
}
