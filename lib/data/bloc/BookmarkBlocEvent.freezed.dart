// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'BookmarkBlocEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BookmarkBlocEventTearOff {
  const _$BookmarkBlocEventTearOff();

  Load load() {
    return const Load();
  }

  AddBookmark addBookmark({@required IPersistentBookmark bookmark}) {
    return AddBookmark(
      bookmark: bookmark,
    );
  }

  RemoveBookmark removeBookmark({@required IPersistentBookmark bookmark}) {
    return RemoveBookmark(
      bookmark: bookmark,
    );
  }

  UpdateBookmark updateBookmark({@required IPersistentBookmark bookmark}) {
    return UpdateBookmark(
      bookmark: bookmark,
    );
  }

  IncrementProgress incrementProgress(
      {@required IPersistentBookmark bookmark}) {
    return IncrementProgress(
      bookmark: bookmark,
    );
  }
}

// ignore: unused_element
const $BookmarkBlocEvent = _$BookmarkBlocEventTearOff();

mixin _$BookmarkBlocEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
    @required Result orElse(),
  });
}

abstract class $BookmarkBlocEventCopyWith<$Res> {
  factory $BookmarkBlocEventCopyWith(
          BookmarkBlocEvent value, $Res Function(BookmarkBlocEvent) then) =
      _$BookmarkBlocEventCopyWithImpl<$Res>;
}

class _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $BookmarkBlocEventCopyWith<$Res> {
  _$BookmarkBlocEventCopyWithImpl(this._value, this._then);

  final BookmarkBlocEvent _value;
  // ignore: unused_field
  final $Res Function(BookmarkBlocEvent) _then;
}

abstract class $LoadCopyWith<$Res> {
  factory $LoadCopyWith(Load value, $Res Function(Load) then) =
      _$LoadCopyWithImpl<$Res>;
}

class _$LoadCopyWithImpl<$Res> extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $LoadCopyWith<$Res> {
  _$LoadCopyWithImpl(Load _value, $Res Function(Load) _then)
      : super(_value, (v) => _then(v as Load));

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
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return load();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
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
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return load(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
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
  factory $AddBookmarkCopyWith(
          AddBookmark value, $Res Function(AddBookmark) then) =
      _$AddBookmarkCopyWithImpl<$Res>;
  $Res call({IPersistentBookmark bookmark});
}

class _$AddBookmarkCopyWithImpl<$Res>
    extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $AddBookmarkCopyWith<$Res> {
  _$AddBookmarkCopyWithImpl(
      AddBookmark _value, $Res Function(AddBookmark) _then)
      : super(_value, (v) => _then(v as AddBookmark));

  @override
  AddBookmark get _value => super._value as AddBookmark;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(AddBookmark(
      bookmark: bookmark == freezed
          ? _value.bookmark
          : bookmark as IPersistentBookmark,
    ));
  }
}

class _$AddBookmark implements AddBookmark {
  const _$AddBookmark({@required this.bookmark}) : assert(bookmark != null);

  @override
  final IPersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.addBookmark(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AddBookmark &&
            (identical(other.bookmark, bookmark) ||
                const DeepCollectionEquality()
                    .equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $AddBookmarkCopyWith<AddBookmark> get copyWith =>
      _$AddBookmarkCopyWithImpl<AddBookmark>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return addBookmark(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addBookmark != null) {
      return addBookmark(bookmark);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return addBookmark(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addBookmark != null) {
      return addBookmark(this);
    }
    return orElse();
  }
}

abstract class AddBookmark implements BookmarkBlocEvent {
  const factory AddBookmark({@required IPersistentBookmark bookmark}) =
      _$AddBookmark;

  IPersistentBookmark get bookmark;
  $AddBookmarkCopyWith<AddBookmark> get copyWith;
}

abstract class $RemoveBookmarkCopyWith<$Res> {
  factory $RemoveBookmarkCopyWith(
          RemoveBookmark value, $Res Function(RemoveBookmark) then) =
      _$RemoveBookmarkCopyWithImpl<$Res>;
  $Res call({IPersistentBookmark bookmark});
}

class _$RemoveBookmarkCopyWithImpl<$Res>
    extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $RemoveBookmarkCopyWith<$Res> {
  _$RemoveBookmarkCopyWithImpl(
      RemoveBookmark _value, $Res Function(RemoveBookmark) _then)
      : super(_value, (v) => _then(v as RemoveBookmark));

  @override
  RemoveBookmark get _value => super._value as RemoveBookmark;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(RemoveBookmark(
      bookmark: bookmark == freezed
          ? _value.bookmark
          : bookmark as IPersistentBookmark,
    ));
  }
}

class _$RemoveBookmark implements RemoveBookmark {
  const _$RemoveBookmark({@required this.bookmark}) : assert(bookmark != null);

  @override
  final IPersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.removeBookmark(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RemoveBookmark &&
            (identical(other.bookmark, bookmark) ||
                const DeepCollectionEquality()
                    .equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $RemoveBookmarkCopyWith<RemoveBookmark> get copyWith =>
      _$RemoveBookmarkCopyWithImpl<RemoveBookmark>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return removeBookmark(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
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
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return removeBookmark(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
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
  const factory RemoveBookmark({@required IPersistentBookmark bookmark}) =
      _$RemoveBookmark;

  IPersistentBookmark get bookmark;
  $RemoveBookmarkCopyWith<RemoveBookmark> get copyWith;
}

abstract class $UpdateBookmarkCopyWith<$Res> {
  factory $UpdateBookmarkCopyWith(
          UpdateBookmark value, $Res Function(UpdateBookmark) then) =
      _$UpdateBookmarkCopyWithImpl<$Res>;
  $Res call({IPersistentBookmark bookmark});
}

class _$UpdateBookmarkCopyWithImpl<$Res>
    extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $UpdateBookmarkCopyWith<$Res> {
  _$UpdateBookmarkCopyWithImpl(
      UpdateBookmark _value, $Res Function(UpdateBookmark) _then)
      : super(_value, (v) => _then(v as UpdateBookmark));

  @override
  UpdateBookmark get _value => super._value as UpdateBookmark;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(UpdateBookmark(
      bookmark: bookmark == freezed
          ? _value.bookmark
          : bookmark as IPersistentBookmark,
    ));
  }
}

class _$UpdateBookmark implements UpdateBookmark {
  const _$UpdateBookmark({@required this.bookmark}) : assert(bookmark != null);

  @override
  final IPersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.updateBookmark(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateBookmark &&
            (identical(other.bookmark, bookmark) ||
                const DeepCollectionEquality()
                    .equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $UpdateBookmarkCopyWith<UpdateBookmark> get copyWith =>
      _$UpdateBookmarkCopyWithImpl<UpdateBookmark>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return updateBookmark(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateBookmark != null) {
      return updateBookmark(bookmark);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(Load value),
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return updateBookmark(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (updateBookmark != null) {
      return updateBookmark(this);
    }
    return orElse();
  }
}

abstract class UpdateBookmark implements BookmarkBlocEvent {
  const factory UpdateBookmark({@required IPersistentBookmark bookmark}) =
      _$UpdateBookmark;

  IPersistentBookmark get bookmark;
  $UpdateBookmarkCopyWith<UpdateBookmark> get copyWith;
}

abstract class $IncrementProgressCopyWith<$Res> {
  factory $IncrementProgressCopyWith(
          IncrementProgress value, $Res Function(IncrementProgress) then) =
      _$IncrementProgressCopyWithImpl<$Res>;
  $Res call({IPersistentBookmark bookmark});
}

class _$IncrementProgressCopyWithImpl<$Res>
    extends _$BookmarkBlocEventCopyWithImpl<$Res>
    implements $IncrementProgressCopyWith<$Res> {
  _$IncrementProgressCopyWithImpl(
      IncrementProgress _value, $Res Function(IncrementProgress) _then)
      : super(_value, (v) => _then(v as IncrementProgress));

  @override
  IncrementProgress get _value => super._value as IncrementProgress;

  @override
  $Res call({
    Object bookmark = freezed,
  }) {
    return _then(IncrementProgress(
      bookmark: bookmark == freezed
          ? _value.bookmark
          : bookmark as IPersistentBookmark,
    ));
  }
}

class _$IncrementProgress implements IncrementProgress {
  const _$IncrementProgress({@required this.bookmark})
      : assert(bookmark != null);

  @override
  final IPersistentBookmark bookmark;

  @override
  String toString() {
    return 'BookmarkBlocEvent.incrementProgress(bookmark: $bookmark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is IncrementProgress &&
            (identical(other.bookmark, bookmark) ||
                const DeepCollectionEquality()
                    .equals(other.bookmark, bookmark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(bookmark);

  @override
  $IncrementProgressCopyWith<IncrementProgress> get copyWith =>
      _$IncrementProgressCopyWithImpl<IncrementProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result addBookmark(IPersistentBookmark bookmark),
    @required Result removeBookmark(IPersistentBookmark bookmark),
    @required Result updateBookmark(IPersistentBookmark bookmark),
    @required Result incrementProgress(IPersistentBookmark bookmark),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return incrementProgress(bookmark);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result addBookmark(IPersistentBookmark bookmark),
    Result removeBookmark(IPersistentBookmark bookmark),
    Result updateBookmark(IPersistentBookmark bookmark),
    Result incrementProgress(IPersistentBookmark bookmark),
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
    @required Result addBookmark(AddBookmark value),
    @required Result removeBookmark(RemoveBookmark value),
    @required Result updateBookmark(UpdateBookmark value),
    @required Result incrementProgress(IncrementProgress value),
  }) {
    assert(load != null);
    assert(addBookmark != null);
    assert(removeBookmark != null);
    assert(updateBookmark != null);
    assert(incrementProgress != null);
    return incrementProgress(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(Load value),
    Result addBookmark(AddBookmark value),
    Result removeBookmark(RemoveBookmark value),
    Result updateBookmark(UpdateBookmark value),
    Result incrementProgress(IncrementProgress value),
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
  const factory IncrementProgress({@required IPersistentBookmark bookmark}) =
      _$IncrementProgress;

  IPersistentBookmark get bookmark;
  $IncrementProgressCopyWith<IncrementProgress> get copyWith;
}
