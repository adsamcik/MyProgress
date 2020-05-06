abstract class ISearchResult<T> {
  T get value;

  double get match;
}

class SearchResult<T> implements ISearchResult<T> {
  @override
  final T value;
  @override
  final double match;

  SearchResult(this.value, this.match);
}

class NoSearchResult<T> implements ISearchResult<T> {
  @override
  final T value;

  @override
  double get match => 0.0;

  NoSearchResult(this.value);
}
