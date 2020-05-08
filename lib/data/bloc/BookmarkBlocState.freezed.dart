// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'BookmarkBlocState.dart';

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
      {@required List<IPersistentBookmark> bookmarkList,
      @required int version}) {
    return Ready(
      bookmarkList: bookmarkList,
      version: version,
    );
  }

  Error error() {
    return const Error();
  }
}

// ignore: unused_element
const $BookmarkBlocState = _$BookmarkBlocStateTearOff();

mixin _$BookmarkBlocState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(List<IPersistentBookmark> bookmarkList, int version),
    @required Result error(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(List<IPersistentBookmark> bookmarkList, int version),
    Result error(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
    @required Result error(Error value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    Result error(Error value),
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
    @required Result ready(List<IPersistentBookmark> bookmarkList, int version),
    @required Result error(),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return notReady();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(List<IPersistentBookmark> bookmarkList, int version),
    Result error(),
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
    @required Result error(Error value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return notReady(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    Result error(Error value),
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
  $Res call({List<IPersistentBookmark> bookmarkList, int version});
}

class _$ReadyCopyWithImpl<$Res> extends _$BookmarkBlocStateCopyWithImpl<$Res>
    implements $ReadyCopyWith<$Res> {
  _$ReadyCopyWithImpl(Ready _value, $Res Function(Ready) _then)
      : super(_value, (v) => _then(v as Ready));

  @override
  Ready get _value => super._value as Ready;

  @override
  $Res call({
    Object bookmarkList = freezed,
    Object version = freezed,
  }) {
    return _then(Ready(
      bookmarkList: bookmarkList == freezed
          ? _value.bookmarkList
          : bookmarkList as List<IPersistentBookmark>,
      version: version == freezed ? _value.version : version as int,
    ));
  }
}

class _$Ready implements Ready {
  const _$Ready({@required this.bookmarkList, @required this.version})
      : assert(bookmarkList != null),
        assert(version != null);

  @override
  final List<IPersistentBookmark> bookmarkList;
  @override
  final int version;

  @override
  String toString() {
    return 'BookmarkBlocState.ready(bookmarkList: $bookmarkList, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Ready &&
            (identical(other.bookmarkList, bookmarkList) ||
                const DeepCollectionEquality()
                    .equals(other.bookmarkList, bookmarkList)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bookmarkList) ^
      const DeepCollectionEquality().hash(version);

  @override
  $ReadyCopyWith<Ready> get copyWith =>
      _$ReadyCopyWithImpl<Ready>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(List<IPersistentBookmark> bookmarkList, int version),
    @required Result error(),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return ready(bookmarkList, version);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(List<IPersistentBookmark> bookmarkList, int version),
    Result error(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(bookmarkList, version);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
    @required Result error(Error value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return ready(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    Result error(Error value),
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
      {@required List<IPersistentBookmark> bookmarkList,
      @required int version}) = _$Ready;

  List<IPersistentBookmark> get bookmarkList;
  int get version;
  $ReadyCopyWith<Ready> get copyWith;
}

abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
}

class _$ErrorCopyWithImpl<$Res> extends _$BookmarkBlocStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;
}

class _$Error implements Error {
  const _$Error();

  @override
  String toString() {
    return 'BookmarkBlocState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Error);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(List<IPersistentBookmark> bookmarkList, int version),
    @required Result error(),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return error();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(List<IPersistentBookmark> bookmarkList, int version),
    Result error(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(NotReady value),
    @required Result ready(Ready value),
    @required Result error(Error value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(NotReady value),
    Result ready(Ready value),
    Result error(Error value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements BookmarkBlocState {
  const factory Error() = _$Error;
}
