extension MapExtensions<K, V> on Map<K, V> {
  /// Returns a new map where all entries of this map are transformed by
  /// the given [f] function.
  Iterable<RV> mapToIterable<RV>(RV Function(K key, V value) f) {
    var list = <RV>[];
    forEach((key, value) {
      list.add(f(key, value));
    });
    return list;
  }
}
