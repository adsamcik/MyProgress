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

  SetPreference setPreference({@required String key, @required dynamic value}) {
    return SetPreference(
      key: key,
      value: value,
    );
  }

  UpdateFilterData updateFilterData({@required FilterData data}) {
    return UpdateFilterData(
      data: data,
    );
  }
}

// ignore: unused_element
const $PreferenceBlocEvent = _$PreferenceBlocEventTearOff();

mixin _$PreferenceBlocEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result setPreference(String key, dynamic value),
    @required Result updateFilterData(FilterData data),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result setPreference(String key, dynamic value),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(LoadPreferences value),
    @required Result setPreference(SetPreference value),
    @required Result updateFilterData(UpdateFilterData value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result setPreference(SetPreference value),
    Result updateFilterData(UpdateFilterData value),
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
    @required Result setPreference(String key, dynamic value),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return load();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result setPreference(String key, dynamic value),
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
    @required Result load(LoadPreferences value),
    @required Result setPreference(SetPreference value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return load(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result setPreference(SetPreference value),
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

abstract class LoadPreferences implements PreferenceBlocEvent {
  const factory LoadPreferences() = _$LoadPreferences;
}

abstract class $SetPreferenceCopyWith<$Res> {
  factory $SetPreferenceCopyWith(
          SetPreference value, $Res Function(SetPreference) then) =
      _$SetPreferenceCopyWithImpl<$Res>;
  $Res call({String key, dynamic value});
}

class _$SetPreferenceCopyWithImpl<$Res>
    extends _$PreferenceBlocEventCopyWithImpl<$Res>
    implements $SetPreferenceCopyWith<$Res> {
  _$SetPreferenceCopyWithImpl(
      SetPreference _value, $Res Function(SetPreference) _then)
      : super(_value, (v) => _then(v as SetPreference));

  @override
  SetPreference get _value => super._value as SetPreference;

  @override
  $Res call({
    Object key = freezed,
    Object value = freezed,
  }) {
    return _then(SetPreference(
      key: key == freezed ? _value.key : key as String,
      value: value == freezed ? _value.value : value as dynamic,
    ));
  }
}

class _$SetPreference implements SetPreference {
  const _$SetPreference({@required this.key, @required this.value})
      : assert(key != null),
        assert(value != null);

  @override
  final String key;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'PreferenceBlocEvent.setPreference(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SetPreference &&
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
  $SetPreferenceCopyWith<SetPreference> get copyWith =>
      _$SetPreferenceCopyWithImpl<SetPreference>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result setPreference(String key, dynamic value),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return setPreference(key, value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result setPreference(String key, dynamic value),
    Result updateFilterData(FilterData data),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setPreference != null) {
      return setPreference(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result load(LoadPreferences value),
    @required Result setPreference(SetPreference value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return setPreference(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result setPreference(SetPreference value),
    Result updateFilterData(UpdateFilterData value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (setPreference != null) {
      return setPreference(this);
    }
    return orElse();
  }
}

abstract class SetPreference implements PreferenceBlocEvent {
  const factory SetPreference({@required String key, @required dynamic value}) =
      _$SetPreference;

  String get key;
  dynamic get value;
  $SetPreferenceCopyWith<SetPreference> get copyWith;
}

abstract class $UpdateFilterDataCopyWith<$Res> {
  factory $UpdateFilterDataCopyWith(
          UpdateFilterData value, $Res Function(UpdateFilterData) then) =
      _$UpdateFilterDataCopyWithImpl<$Res>;
  $Res call({FilterData data});

  $FilterDataCopyWith<$Res> get data;
}

class _$UpdateFilterDataCopyWithImpl<$Res>
    extends _$PreferenceBlocEventCopyWithImpl<$Res>
    implements $UpdateFilterDataCopyWith<$Res> {
  _$UpdateFilterDataCopyWithImpl(
      UpdateFilterData _value, $Res Function(UpdateFilterData) _then)
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
    return 'PreferenceBlocEvent.updateFilterData(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateFilterData &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @override
  $UpdateFilterDataCopyWith<UpdateFilterData> get copyWith =>
      _$UpdateFilterDataCopyWithImpl<UpdateFilterData>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result load(),
    @required Result setPreference(String key, dynamic value),
    @required Result updateFilterData(FilterData data),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return updateFilterData(data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result load(),
    Result setPreference(String key, dynamic value),
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
    @required Result load(LoadPreferences value),
    @required Result setPreference(SetPreference value),
    @required Result updateFilterData(UpdateFilterData value),
  }) {
    assert(load != null);
    assert(setPreference != null);
    assert(updateFilterData != null);
    return updateFilterData(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result load(LoadPreferences value),
    Result setPreference(SetPreference value),
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

abstract class UpdateFilterData implements PreferenceBlocEvent {
  const factory UpdateFilterData({@required FilterData data}) =
      _$UpdateFilterData;

  FilterData get data;
  $UpdateFilterDataCopyWith<UpdateFilterData> get copyWith;
}
