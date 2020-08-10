// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bookmark_bloc_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BookmarkBlocEventTearOff {
  const _$BookmarkBlocEventTearOff();

// ignore: unused_element
  Load load() {
    return const Load();
  }

// ignore: unused_element
  AddBookmark saveBookmark({@required PersistentBookmark bookmark}) {
    return AddBookmark(
      bookmark: bookmark,
    );
  }

// ignore: unused_element
  RemoveBookmark removeBookmark({@required PersistentBookmark bookmark}) {
    return RemoveBookmark(
      bookmark: bookmark,
    );
  }

// ignore: unused_element
  IncrementProgress incrementProgress({@required PersistentBookmark bookmark}) {
    return IncrementProgress(
      bookmark: bookmark,
    );
  }

// ignore: unused_element
  UpdateFilterQuery updateFilterQuery({@required String query}) {
    return UpdateFilterQuery(
      query: query,
    );
  }

// ignore: unused_element
  UpdateFilterData updateFilterData({@required FilterData data}) {
    return UpdateFilterData(
      data: data,
    );
  }
}

// ignore: unused_element
const $BookmarkBlocEvent = _$BookmarkBlocEventTearOff();

mixin _$BookmarkBlocEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  });
}

abstract class $BookmarkBlocEventCopyWith<$Res> {
  factory $BookmarkBlocEventCopyWith(BookmarkBlocEvent value, $Res Function(BookmarkBlocEvent) then) =
      _$BookmarkBlocEventCopyWithImpl<$Res>;
}

class _$BookmarkBlocEventCopyWithImpl<$Res> implements $BookmarkBlocEventCopyWith<$Res> {
  _$BookmarkBlocEventCopyWithImpl(this._value, this._then);

  final BookmarkBlocEvent _value;
  // ignore: unused_field
  final $Res Function(BookmarkBlocEvent) _then;
}

abstract class $LoadCopyWith<$Res> {
  factory $LoadCopyWith(Load value, $Res Function(Load) then) = _$LoadCopyWithImpl<$Res>;
}

class _$LoadCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res> implements $LoadCopyWith<$Res> {
  _$LoadCopyWithImpl(Load _value, $Res Function(Load) _then) : super(_value, (v) => _then(v as Load));

  @override
  Load get _value => super._value as Load;
}

class _$Load implements Load {
  const _$Load();

  @override
  String toString() {
    return 'BookmarkBlocEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return load();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return load(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class Load implements BookmarkBlocEvent {
  const factory Load() = _$Load;
}

abstract class $AddBookmarkCopyWith<$Res> {
  factory $AddBookmarkCopyWith(AddBookmark value, $Res Function(AddBookmark) then) = _$AddBookmarkCopyWithImpl<$Res>;
  $Res call({PersistentBookmark bookmark});
}

class _$AddBookmarkCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $AddBookmarkCopyWith<$Res> {
  _$AddBookmarkCopyWithImpl(AddBookmark _value, $Res Function(AddBookmark) _then)
      : super(_value, (v) => _then(v as AddBookmark));

  @override
  AddBookmark get _value => super._value as AddBookmark;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(AddBookmark(
      bookmark: bookmark == freezed ? _value.bookmark : bookmark as PersistentBookmark,
    ));
  }
}

class _$AddBookmark implements AddBookmark {
  const _$AddBookmark({@required this.bookmark}) : assert(bookmark != null);

  @override
  final PersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.saveBookmark(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AddBookmark &&
            (identical(other.bookmark, bookmark) || const DeepCollectionEquality().equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $AddBookmarkCopyWith<AddBookmark> get copyWith => _$AddBookmarkCopyWithImpl<AddBookmark>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return saveBookmark(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (saveBookmark != null) {
      return saveBookmark(bookmark);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return saveBookmark(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (saveBookmark != null) {
      return saveBookmark(this);
    }
    return orElse();
  }
}

abstract class AddBookmark implements BookmarkBlocEvent {
  const factory AddBookmark({@required PersistentBookmark bookmark}) = _$AddBookmark;

  PersistentBookmark get bookmark;
  $AddBookmarkCopyWith<AddBookmark> get copyWith;
}

abstract class $RemoveBookmarkCopyWith<$Res> {
  factory $RemoveBookmarkCopyWith(RemoveBookmark value, $Res Function(RemoveBookmark) then) =
      _$RemoveBookmarkCopyWithImpl<$Res>;
  $Res call({PersistentBookmark bookmark});
}

class _$RemoveBookmarkCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $RemoveBookmarkCopyWith<$Res> {
  _$RemoveBookmarkCopyWithImpl(RemoveBookmark _value, $Res Function(RemoveBookmark) _then)
      : super(_value, (v) => _then(v as RemoveBookmark));

  @override
  RemoveBookmark get _value => super._value as RemoveBookmark;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(RemoveBookmark(
      bookmark: bookmark == freezed ? _value.bookmark : bookmark as PersistentBookmark,
    ));
  }
}

class _$RemoveBookmark implements RemoveBookmark {
  const _$RemoveBookmark({@required this.bookmark}) : assert(bookmark != null);

  @override
  final PersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.removeBookmark(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RemoveBookmark &&
            (identical(other.bookmark, bookmark) || const DeepCollectionEquality().equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $RemoveBookmarkCopyWith<RemoveBookmark> get copyWith =>
      _$RemoveBookmarkCopyWithImpl<RemoveBookmark>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return removeBookmark(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeBookmark != null) {
      return removeBookmark(bookmark);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return removeBookmark(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeBookmark != null) {
      return removeBookmark(this);
    }
    return orElse();
  }
}

abstract class RemoveBookmark implements BookmarkBlocEvent {
  const factory RemoveBookmark({@required PersistentBookmark bookmark}) = _$RemoveBookmark;

  PersistentBookmark get bookmark;
  $RemoveBookmarkCopyWith<RemoveBookmark> get copyWith;
}

abstract class $IncrementProgressCopyWith<$Res> {
  factory $IncrementProgressCopyWith(IncrementProgress value, $Res Function(IncrementProgress) then) =
      _$IncrementProgressCopyWithImpl<$Res>;
  $Res call({PersistentBookmark bookmark});
}

class _$IncrementProgressCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $IncrementProgressCopyWith<$Res> {
  _$IncrementProgressCopyWithImpl(IncrementProgress _value, $Res Function(IncrementProgress) _then)
      : super(_value, (v) => _then(v as IncrementProgress));

  @override
  IncrementProgress get _value => super._value as IncrementProgress;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(IncrementProgress(
      bookmark: bookmark == freezed ? _value.bookmark : bookmark as PersistentBookmark,
    ));
  }
}

class _$IncrementProgress implements IncrementProgress {
  const _$IncrementProgress({@required this.bookmark}) : assert(bookmark != null);

  @override
  final PersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.incrementProgress(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IncrementProgress &&
            (identical(other.bookmark, bookmark) || const DeepCollectionEquality().equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $IncrementProgressCopyWith<IncrementProgress> get copyWith =>
      _$IncrementProgressCopyWithImpl<IncrementProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return incrementProgress(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (incrementProgress != null) {
      return incrementProgress(bookmark);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return incrementProgress(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (incrementProgress != null) {
      return incrementProgress(this);
    }
    return orElse();
  }
}

abstract class IncrementProgress implements BookmarkBlocEvent {
  const factory IncrementProgress({@required PersistentBookmark bookmark}) = _$IncrementProgress;

  PersistentBookmark get bookmark;
  $IncrementProgressCopyWith<IncrementProgress> get copyWith;
}

abstract class $UpdateFilterQueryCopyWith<$Res> {
  factory $UpdateFilterQueryCopyWith(UpdateFilterQuery value, $Res Function(UpdateFilterQuery) then) =
      _$UpdateFilterQueryCopyWithImpl<$Res>;
  $Res call({String query});
}

class _$UpdateFilterQueryCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $UpdateFilterQueryCopyWith<$Res> {
  _$UpdateFilterQueryCopyWithImpl(UpdateFilterQuery _value, $Res Function(UpdateFilterQuery) _then)
      : super(_value, (v) => _then(v as UpdateFilterQuery));

  @override
  UpdateFilterQuery get _value => super._value as UpdateFilterQuery;

  @override
  $Res call({
    Object query = freezed,
  }) {
    return _then(UpdateFilterQuery(
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

class _$UpdateFilterQuery implements UpdateFilterQuery {
  const _$UpdateFilterQuery({@required this.query}) : assert(query != null);

  @override
  final String query;

  @override
  String toString() {
    return 'BookmarkBlocEvent.updateFilterQuery(query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateFilterQuery &&
            (identical(other.query, query) || const DeepCollectionEquality().equals(other.query, query)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(query);

  @override
  $UpdateFilterQueryCopyWith<UpdateFilterQuery> get copyWith =>
      _$UpdateFilterQueryCopyWithImpl<UpdateFilterQuery>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return updateFilterQuery(query);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateFilterQuery != null) {
      return updateFilterQuery(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return updateFilterQuery(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateFilterQuery != null) {
      return updateFilterQuery(this);
    }
    return orElse();
  }
}

abstract class UpdateFilterQuery implements BookmarkBlocEvent {
  const factory UpdateFilterQuery({@required String query}) = _$UpdateFilterQuery;

  String get query;
  $UpdateFilterQueryCopyWith<UpdateFilterQuery> get copyWith;
}

abstract class $UpdateFilterDataCopyWith<$Res> {
  factory $UpdateFilterDataCopyWith(UpdateFilterData value, $Res Function(UpdateFilterData) then) =
      _$UpdateFilterDataCopyWithImpl<$Res>;
  $Res call({FilterData data});

  $FilterDataCopyWith<$Res> get data;
}

class _$UpdateFilterDataCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $UpdateFilterDataCopyWith<$Res> {
  _$UpdateFilterDataCopyWithImpl(UpdateFilterData _value, $Res Function(UpdateFilterData) _then)
      : super(_value, (v) => _then(v as UpdateFilterData));

  @override
  UpdateFilterData get _value => super._value as UpdateFilterData;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(UpdateFilterData(
      data: data == freezed ? _value.data : data as FilterData,
    ));
  }

  @override
  $FilterDataCopyWith<$Res> get data {
    if (_value.data == null) {
      return null;
    }
    return $FilterDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

class _$UpdateFilterData implements UpdateFilterData {
  const _$UpdateFilterData({@required this.data}) : assert(data != null);

  @override
  final FilterData data;

  @override
  String toString() {
    return 'BookmarkBlocEvent.updateFilterData(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateFilterData &&
            (identical(other.data, data) || const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @override
  $UpdateFilterDataCopyWith<UpdateFilterData> get copyWith =>
      _$UpdateFilterDataCopyWithImpl<UpdateFilterData>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result saveBookmark(PersistentBookmark bookmark),
    @required Result removeBookmark(PersistentBookmark bookmark),
    @required Result incrementProgress(PersistentBookmark bookmark),
    @required Result updateFilterQuery(String query),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return updateFilterData(data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result saveBookmark(PersistentBookmark bookmark),
    Result removeBookmark(PersistentBookmark bookmark),
    Result incrementProgress(PersistentBookmark bookmark),
    Result updateFilterQuery(String query),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateFilterData != null) {
      return updateFilterData(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result saveBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result incrementProgress(IncrementProgress value),
    @required Result updateFilterQuery(UpdateFilterQuery value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(saveBookmark != null);
    assert(removeBookmark != null);
    assert(incrementProgress != null);
    assert(updateFilterQuery != null);
    assert(updateFilterData != null);
    return updateFilterData(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result saveBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result incrementProgress(IncrementProgress value),
    Result updateFilterQuery(UpdateFilterQuery value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateFilterData != null) {
      return updateFilterData(this);
    }
    return orElse();
  }
}

abstract class UpdateFilterData implements BookmarkBlocEvent {
  const factory UpdateFilterData({@required FilterData data}) = _$UpdateFilterData;

  FilterData get data;
  $UpdateFilterDataCopyWith<UpdateFilterData> get copyWith;
}
