// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'PreferenceBlocState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PreferenceBlocStateTearOff {
  const _$PreferenceBlocStateTearOff();

  PreferencesNotReady notReady() {
    return const PreferencesNotReady();
  }

  PreferencesReady ready(
      {@required int version, @required Map<String, dynamic> preferences}) {
    return PreferencesReady(
      version: version,
      preferences: preferences,
    );
  }
}

// ignore: unused_element
const $PreferenceBlocState = _$PreferenceBlocStateTearOff();

mixin _$PreferenceBlocState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(int version, Map<String, dynamic> preferences),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(int version, Map<String, dynamic> preferences),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(PreferencesNotReady value),
    @required Result ready(PreferencesReady value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(PreferencesNotReady value),
    Result ready(PreferencesReady value),
    @required Result orElse(),
  });
}

abstract class $PreferenceBlocStateCopyWith<$Res> {
  factory $PreferenceBlocStateCopyWith(
          PreferenceBlocState value, $Res Function(PreferenceBlocState) then) =
      _$PreferenceBlocStateCopyWithImpl<$Res>;
}

class _$PreferenceBlocStateCopyWithImpl<$Res>
    implements $PreferenceBlocStateCopyWith<$Res> {
  _$PreferenceBlocStateCopyWithImpl(this._value, this._then);

  final PreferenceBlocState _value;
  // ignore: unused_field
  final $Res Function(PreferenceBlocState) _then;
}

abstract class $PreferencesNotReadyCopyWith<$Res> {
  factory $PreferencesNotReadyCopyWith(
          PreferencesNotReady value, $Res Function(PreferencesNotReady) then) =
      _$PreferencesNotReadyCopyWithImpl<$Res>;
}

class _$PreferencesNotReadyCopyWithImpl<$Res>
    extends _$PreferenceBlocStateCopyWithImpl<$Res>
    implements $PreferencesNotReadyCopyWith<$Res> {
  _$PreferencesNotReadyCopyWithImpl(
      PreferencesNotReady _value, $Res Function(PreferencesNotReady) _then)
      : super(_value, (v) => _then(v as PreferencesNotReady));

  @override
  PreferencesNotReady get _value => super._value as PreferencesNotReady;
}

class _$PreferencesNotReady implements PreferencesNotReady {
  const _$PreferencesNotReady();

  @override
  String toString() {
    return 'PreferenceBlocState.notReady()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PreferencesNotReady);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(int version, Map<String, dynamic> preferences),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return notReady();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(int version, Map<String, dynamic> preferences),
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
    @required Result notReady(PreferencesNotReady value),
    @required Result ready(PreferencesReady value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return notReady(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(PreferencesNotReady value),
    Result ready(PreferencesReady value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notReady != null) {
      return notReady(this);
    }
    return orElse();
  }
}

abstract class PreferencesNotReady implements PreferenceBlocState {
  const factory PreferencesNotReady() = _$PreferencesNotReady;
}

abstract class $PreferencesReadyCopyWith<$Res> {
  factory $PreferencesReadyCopyWith(
          PreferencesReady value, $Res Function(PreferencesReady) then) =
      _$PreferencesReadyCopyWithImpl<$Res>;
  $Res call({int version, Map<String, dynamic> preferences});
}

class _$PreferencesReadyCopyWithImpl<$Res>
    extends _$PreferenceBlocStateCopyWithImpl<$Res>
    implements $PreferencesReadyCopyWith<$Res> {
  _$PreferencesReadyCopyWithImpl(
      PreferencesReady _value, $Res Function(PreferencesReady) _then)
      : super(_value, (v) => _then(v as PreferencesReady));

  @override
  PreferencesReady get _value => super._value as PreferencesReady;

  @override
  $Res call({
    Object version = freezed,
    Object preferences = freezed,
  }) {
    return _then(PreferencesReady(
      version: version == freezed ? _value.version : version as int,
      preferences: preferences == freezed
          ? _value.preferences
          : preferences as Map<String, dynamic>,
    ));
  }
}

class _$PreferencesReady implements PreferencesReady {
  const _$PreferencesReady({@required this.version, @required this.preferences})
      : assert(version != null),
        assert(preferences != null);

  @override
  final int version;
  @override
  final Map<String, dynamic> preferences;

  @override
  String toString() {
    return 'PreferenceBlocState.ready(version: $version, preferences: $preferences)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PreferencesReady &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.preferences, preferences) ||
                const DeepCollectionEquality()
                    .equals(other.preferences, preferences)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(preferences);

  @override
  $PreferencesReadyCopyWith<PreferencesReady> get copyWith =>
      _$PreferencesReadyCopyWithImpl<PreferencesReady>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notReady(),
    @required Result ready(int version, Map<String, dynamic> preferences),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return ready(version, preferences);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notReady(),
    Result ready(int version, Map<String, dynamic> preferences),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(version, preferences);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notReady(PreferencesNotReady value),
    @required Result ready(PreferencesReady value),
  }) {
    assert(notReady != null);
    assert(ready != null);
    return ready(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notReady(PreferencesNotReady value),
    Result ready(PreferencesReady value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class PreferencesReady implements PreferenceBlocState {
  const factory PreferencesReady(
      {@required int version,
      @required Map<String, dynamic> preferences}) = _$PreferencesReady;

  int get version;
  Map<String, dynamic> get preferences;
  $PreferencesReadyCopyWith<PreferencesReady> get copyWith;
}
