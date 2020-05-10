// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'PreferenceBlocEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PreferenceBlocEventTearOff {
  const _$PreferenceBlocEventTearOff();

  LoadPreferences load() {
    return const LoadPreferences();
  }

  Set set({@required String key, @required dynamic value}) {
    return Set(
      key: key,
      value: value,
    );
  }
}

// ignore: unused_element
const $PreferenceBlocEvent = _$PreferenceBlocEventTearOff();

mixin _$PreferenceBlocEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result set(String key, dynamic value),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result set(String key, dynamic value),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(LoadPreferences value),
    @required Result set(Set value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result set(Set value),
    @required Result orElse(),
  });
}

abstract class $PreferenceBlocEventCopyWith<$Res> {
  factory $PreferenceBlocEventCopyWith(
          PreferenceBlocEvent value, $Res Function(PreferenceBlocEvent) then) =
      _$PreferenceBlocEventCopyWithImpl<$Res>;
}

class _$PreferenceBlocEventCopyWithImpl<$Res>
    implements $PreferenceBlocEventCopyWith<$Res> {
  _$PreferenceBlocEventCopyWithImpl(this._value, this._then);

  final PreferenceBlocEvent _value;
  // ignore: unused_field
  final $Res Function(PreferenceBlocEvent) _then;
}

abstract class $LoadPreferencesCopyWith<$Res> {
  factory $LoadPreferencesCopyWith(
          LoadPreferences value, $Res Function(LoadPreferences) then) =
      _$LoadPreferencesCopyWithImpl<$Res>;
}

class _$LoadPreferencesCopyWithImpl<$Res>
    extends _$PreferenceBlocEventCopyWithImpl<$Res>
    implements $LoadPreferencesCopyWith<$Res> {
  _$LoadPreferencesCopyWithImpl(
      LoadPreferences _value, $Res Function(LoadPreferences) _then)
      : super(_value, (v) => _then(v as LoadPreferences));

  @override
  LoadPreferences get _value => super._value as LoadPreferences;
}

class _$LoadPreferences implements LoadPreferences {
  const _$LoadPreferences();

  @override
  String toString() {
    return 'PreferenceBlocEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadPreferences);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result set(String key, dynamic value),
  }) {
    assert(load != null);
    assert(set != null);
    return load();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result set(String key, dynamic value),
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
    @required Result load(LoadPreferences value),
    @required Result set(Set value),
  }) {
    assert(load != null);
    assert(set != null);
    return load(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result set(Set value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadPreferences implements PreferenceBlocEvent {
  const factory LoadPreferences() = _$LoadPreferences;
}

abstract class $SetCopyWith<$Res> {
  factory $SetCopyWith(Set value, $Res Function(Set) then) =
      _$SetCopyWithImpl<$Res>;
  $Res call({String key, dynamic value});
}

class _$SetCopyWithImpl<$Res> extends _$PreferenceBlocEventCopyWithImpl<$Res>
    implements $SetCopyWith<$Res> {
  _$SetCopyWithImpl(Set _value, $Res Function(Set) _then)
      : super(_value, (v) => _then(v as Set));

  @override
  Set get _value => super._value as Set;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
  }) {
    return _then(Set(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as dynamic,
    ));
  }
}

class _$Set implements Set {
  const _$Set({@required this.key, @required this.value})
      : assert(key != null),
        assert(value != null);

  @override
  final String key;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'PreferenceBlocEvent.set(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Set &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(value);

  @override
  $SetCopyWith<Set> get copyWith => _$SetCopyWithImpl<Set>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result set(String key, dynamic value),
  }) {
    assert(load != null);
    assert(set != null);
    return set(key, value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result set(String key, dynamic value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (set != null) {
      return set(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(LoadPreferences value),
    @required Result set(Set value),
  }) {
    assert(load != null);
    assert(set != null);
    return set(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result set(Set value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (set != null) {
      return set(this);
    }
    return orElse();
  }
}

abstract class Set implements PreferenceBlocEvent {
  const factory Set({@required String key, @required dynamic value}) = _$Set;

  String get key;
  dynamic get value;
  $SetCopyWith<Set> get copyWith;
}
