// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'bookmark_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BookmarkBlocStateTearOff {
  const _$BookmarkBlocStateTearOff();

  NotReady notReady() {
    return const NotReady();
  }

  Ready ready(
      {@required int version,
      @required List<SearchableBookmark> bookmarkList,
      @required List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
      @required FilterRuntimeData filterData}) {
    return Ready(
      version: version,
      bookmarkList: bookmarkList,
      filteredBookmarkList: filteredBookmarkList,
      filterData: filterData,
    );
  }
}

// ignore: unused_element
const $BookmarkBlocState = _$BookmarkBlocStateTearOff();

mixin _$BookmarkBlocState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required
        Result ready(
            int version,
            List<SearchableBookmark> bookmarkList,
            List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
            FilterRuntimeData filterData),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(
        int version,
        List<SearchableBookmark> bookmarkList,
        List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
        FilterRuntimeData filterData),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    @required Result orElse(),
  });
}

abstract class $BookmarkBlocStateCopyWith<$Res> {
  factory $BookmarkBlocStateCopyWith(
          BookmarkBlocState value, $Res Function(BookmarkBlocState) then) =
      _$BookmarkBlocStateCopyWithImpl<$Res>;
}

class _$BookmarkBlocStateCopyWithImpl<$Res>
    implements $BookmarkBlocStateCopyWith<$Res> {
  _$BookmarkBlocStateCopyWithImpl(this._value, this._then);

  final BookmarkBlocState _value;
  // ignore: unused_field
  final $Res Function(BookmarkBlocState) _then;
}

abstract class $NotReadyCopyWith<$Res> {
  factory $NotReadyCopyWith(NotReady value, $Res Function(NotReady) then) =
      _$NotReadyCopyWithImpl<$Res>;
}

class _$NotReadyCopyWithImpl<$Res> extends _$BookmarkBlocStateCopyWithImpl<$Res>
    implements $NotReadyCopyWith<$Res> {
  _$NotReadyCopyWithImpl(NotReady _value, $Res Function(NotReady) _then)
      : super(_value, (v) => _then(v as NotReady));

  @override
  NotReady get _value => super._value as NotReady;
}

class _$NotReady implements NotReady {
  const _$NotReady();

  @override
  String toString() {
    return 'BookmarkBlocState.notReady()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NotReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required
        Result ready(
            int version,
            List<SearchableBookmark> bookmarkList,
            List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
            FilterRuntimeData filterData),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return notReady();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(
        int version,
        List<SearchableBookmark> bookmarkList,
        List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
        FilterRuntimeData filterData),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notReady != null) {
      return notReady();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return notReady(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notReady != null) {
      return notReady(this);
    }
    return orElse();
  }
}

abstract class NotReady implements BookmarkBlocState {
  const factory NotReady() = _$NotReady;
}

abstract class $ReadyCopyWith<$Res> {
  factory $ReadyCopyWith(Ready value, $Res Function(Ready) then) =
      _$ReadyCopyWithImpl<$Res>;
  $Res call(
      {int version,
      List<SearchableBookmark> bookmarkList,
      List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
      FilterRuntimeData filterData});
}

class _$ReadyCopyWithImpl<$Res> extends _$BookmarkBlocStateCopyWithImpl<$Res>
    implements $ReadyCopyWith<$Res> {
  _$ReadyCopyWithImpl(Ready _value, $Res Function(Ready) _then)
      : super(_value, (v) => _then(v as Ready));

  @override
  Ready get _value => super._value as Ready;

  @override
  $Res call({
    Object version = freezed,
    Object bookmarkList = freezed,
    Object filteredBookmarkList = freezed,
    Object filterData = freezed,
  }) {
    return _then(Ready(
      version: version == freezed ? _value.version : version as int,
      bookmarkList: bookmarkList == freezed
          ? _value.bookmarkList
          : bookmarkList as List<SearchableBookmark>,
      filteredBookmarkList: filteredBookmarkList == freezed
          ? _value.filteredBookmarkList
          : filteredBookmarkList as List<ISearchResult<PersistentBookmark>>,
      filterData: filterData == freezed
          ? _value.filterData
          : filterData as FilterRuntimeData,
    ));
  }
}

class _$Ready implements Ready {
  const _$Ready(
      {@required this.version,
      @required this.bookmarkList,
      @required this.filteredBookmarkList,
      @required this.filterData})
      : assert(version != null),
        assert(bookmarkList != null),
        assert(filteredBookmarkList != null),
        assert(filterData != null);

  @override
  final int version;
  @override
  final List<SearchableBookmark> bookmarkList;
  @override
  final List<ISearchResult<PersistentBookmark>> filteredBookmarkList;
  @override
  final FilterRuntimeData filterData;

  @override
  String toString() {
    return 'BookmarkBlocState.ready(version: $version, bookmarkList: $bookmarkList, filteredBookmarkList: $filteredBookmarkList, filterData: $filterData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Ready &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.bookmarkList, bookmarkList) ||
                const DeepCollectionEquality()
                    .equals(other.bookmarkList, bookmarkList)) &&
            (identical(other.filteredBookmarkList, filteredBookmarkList) ||
                const DeepCollectionEquality().equals(
                    other.filteredBookmarkList, filteredBookmarkList)) &&
            (identical(other.filterData, filterData) ||
                const DeepCollectionEquality()
                    .equals(other.filterData, filterData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(bookmarkList) ^
      const DeepCollectionEquality().hash(filteredBookmarkList) ^
      const DeepCollectionEquality().hash(filterData);

  @override
  $ReadyCopyWith<Ready> get copyWith =>
      _$ReadyCopyWithImpl<Ready>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required
        Result ready(
            int version,
            List<SearchableBookmark> bookmarkList,
            List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
            FilterRuntimeData filterData),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return ready(version, bookmarkList, filteredBookmarkList, filterData);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(
        int version,
        List<SearchableBookmark> bookmarkList,
        List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
        FilterRuntimeData filterData),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(version, bookmarkList, filteredBookmarkList, filterData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return ready(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class Ready implements BookmarkBlocState {
  const factory Ready(
      {@required int version,
      @required List<SearchableBookmark> bookmarkList,
      @required List<ISearchResult<PersistentBookmark>> filteredBookmarkList,
      @required FilterRuntimeData filterData}) = _$Ready;

  int get version;
  List<SearchableBookmark> get bookmarkList;
  List<ISearchResult<PersistentBookmark>> get filteredBookmarkList;
  FilterRuntimeData get filterData;
  $ReadyCopyWith<Ready> get copyWith;
}
