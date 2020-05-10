// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return _Preference.fromJson(json);
}

class _$PreferenceTearOff {
  const _$PreferenceTearOff();

  _Preference call({@required String key}) {
    return _Preference(
      key: key,
    );
  }
}

// ignore: unused_element
const $Preference = _$PreferenceTearOff();

mixin _$Preference {
  String get key;

  Map<String, dynamic> toJson();
  $PreferenceCopyWith<Preference> get copyWith;
}

abstract class $PreferenceCopyWith<$Res> {
  factory $PreferenceCopyWith(
          Preference value, $Res Function(Preference) then) =
      _$PreferenceCopyWithImpl<$Res>;
  $Res call({String key});
}

class _$PreferenceCopyWithImpl<$Res> implements $PreferenceCopyWith<$Res> {
  _$PreferenceCopyWithImpl(this._value, this._then);

  final Preference _value;
  // ignore: unused_field
  final $Res Function(Preference) _then;

  @override
  $Res call({
    Object key = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as String,
    ));
  }
}

abstract class _$PreferenceCopyWith<$Res> implements $PreferenceCopyWith<$Res> {
  factory _$PreferenceCopyWith(
          _Preference value, $Res Function(_Preference) then) =
      __$PreferenceCopyWithImpl<$Res>;
  @override
  $Res call({String key});
}

class __$PreferenceCopyWithImpl<$Res> extends _$PreferenceCopyWithImpl<$Res>
    implements _$PreferenceCopyWith<$Res> {
  __$PreferenceCopyWithImpl(
      _Preference _value, $Res Function(_Preference) _then)
      : super(_value, (v) => _then(v as _Preference));

  @override
  _Preference get _value => super._value as _Preference;

  @override
  $Res call({
    Object key = freezed,
  }) {
    return _then(_Preference(
      key: key == freezed ? _value.key : key as String,
    ));
  }
}

@JsonSerializable()
class _$_Preference implements _Preference {
  _$_Preference({@required this.key}) : assert(key != null);

  factory _$_Preference.fromJson(Map<String, dynamic> json) =>
      _$_$_PreferenceFromJson(json);

  @override
  final String key;

  @override
  String toString() {
    return 'Preference(key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Preference &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(key);

  @override
  _$PreferenceCopyWith<_Preference> get copyWith =>
      __$PreferenceCopyWithImpl<_Preference>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PreferenceToJson(this);
  }
}

abstract class _Preference implements Preference {
  factory _Preference({@required String key}) = _$_Preference;

  factory _Preference.fromJson(Map<String, dynamic> json) =
      _$_Preference.fromJson;

  @override
  String get key;
  @override
  _$PreferenceCopyWith<_Preference> get copyWith;
}
