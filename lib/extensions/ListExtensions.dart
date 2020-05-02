extension ListExtensions<T> on List<T> {
  List<T> filterWithIndexList( List<int> indexes) {
    var list = List<T>(indexes.length);
    for (var i = 0; i < indexes.length; i++) {
      list[i] = this[indexes[i]];
    }
    return list;
  }
}
