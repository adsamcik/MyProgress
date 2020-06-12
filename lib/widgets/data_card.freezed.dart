// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'data_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$CardRowTearOff {
  const _$CardRowTearOff();

  _CardRowImpl call({@required String title, @required String value, IconData icon, void Function() onTap}) {
    return _CardRowImpl(
      title: title,
      value: value,
      icon: icon,
      onTap: onTap,
    );
  }
}

// ignore: unused_element
const $CardRow = _$CardRowTearOff();

mixin _$CardRow {
  String get title;
  String get value;
  IconData get icon;
  void Function() get onTap;

  $CardRowCopyWith<CardRow> get copyWith;
}

abstract class $CardRowCopyWith<$Res> {
  factory $CardRowCopyWith(CardRow value, $Res Function(CardRow) then) = _$CardRowCopyWithImpl<$Res>;
  $Res call({String title, String value, IconData icon, void Function() onTap});
}

class _$CardRowCopyWithImpl<$Res> implements $CardRowCopyWith<$Res> {
  _$CardRowCopyWithImpl(this._value, this._then);

  final CardRow _value;
  // ignore: unused_field
  final $Res Function(CardRow) _then;

  @override
  $Res call({
    Object title = freezed,
    Object value = freezed,
    Object icon = freezed,
    Object onTap = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      value: value == freezed ? _value.value : value as String,
      icon: icon == freezed ? _value.icon : icon as IconData,
      onTap: onTap == freezed ? _value.onTap : onTap as void Function(),
    ));
  }
}

abstract class _$CardRowImplCopyWith<$Res> implements $CardRowCopyWith<$Res> {
  factory _$CardRowImplCopyWith(_CardRowImpl value, $Res Function(_CardRowImpl) then) =
      __$CardRowImplCopyWithImpl<$Res>;
  @override
  $Res call({String title, String value, IconData icon, void Function() onTap});
}

class __$CardRowImplCopyWithImpl<$Res> extends _$CardRowCopyWithImpl<$Res> implements _$CardRowImplCopyWith<$Res> {
  __$CardRowImplCopyWithImpl(_CardRowImpl _value, $Res Function(_CardRowImpl) _then)
      : super(_value, (v) => _then(v as _CardRowImpl));

  @override
  _CardRowImpl get _value => super._value as _CardRowImpl;

  @override
  $Res call({
    Object title = freezed,
    Object value = freezed,
    Object icon = freezed,
    Object onTap = freezed,
  }) {
    return _then(_CardRowImpl(
      title: title == freezed ? _value.title : title as String,
      value: value == freezed ? _value.value : value as String,
      icon: icon == freezed ? _value.icon : icon as IconData,
      onTap: onTap == freezed ? _value.onTap : onTap as void Function(),
    ));
  }
}

class _$_CardRowImpl with DiagnosticableTreeMixin implements _CardRowImpl {
  _$_CardRowImpl({@required this.title, @required this.value, this.icon, this.onTap})
      : assert(title != null),
        assert(value != null);

  @override
  final String title;
  @override
  final String value;
  @override
  final IconData icon;
  @override
  final void Function() onTap;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CardRow(title: $title, value: $value, icon: $icon, onTap: $onTap)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CardRow'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('onTap', onTap));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CardRowImpl &&
            (identical(other.title, title) || const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.value, value) || const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.icon, icon) || const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.onTap, onTap) || const DeepCollectionEquality().equals(other.onTap, onTap)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(onTap);

  @override
  _$CardRowImplCopyWith<_CardRowImpl> get copyWith => __$CardRowImplCopyWithImpl<_CardRowImpl>(this, _$identity);
}

abstract class _CardRowImpl implements CardRow {
  factory _CardRowImpl({@required String title, @required String value, IconData icon, void Function() onTap}) =
      _$_CardRowImpl;

  @override
  String get title;
  @override
  String get value;
  @override
  IconData get icon;
  @override
  void Function() get onTap;
  @override
  _$CardRowImplCopyWith<_CardRowImpl> get copyWith;
}
