class Pair<T1, T2> {
  T1 item1;
  T2 item2;

  Pair(this.item1, this.item2);

  @override
  String toString() {
    return 'Pair{item1: $item1, item2: $item2}';
  }
}
