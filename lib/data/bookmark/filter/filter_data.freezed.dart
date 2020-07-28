// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'filter_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
FilterData _$FilterDataFromJson(Map<String, dynamic> json) {
  return _FilterData.fromJson(json);
}

class _$FilterDataTearOff {
  const _$FilterDataTearOff();

// ignore: unused_element
  _FilterData call(
      {bool abandoned = false,
      bool ongoing = true,
      bool finished = false,
      bool ended = true}) {
    return _FilterData(
      abandoned: abandoned,
      ongoing: ongoing,
      finished: finished,
      ended: ended,
    );
  }
}

// ignore: unused_element
const $FilterData = _$FilterDataTearOff();

mixin _$FilterData {
  bool get abandoned;
  bool get ongoing;
  bool get finished;
  bool get ended;

  Map<String, dynamic> toJson();
  $FilterDataCopyWith<FilterData> get copyWith;
}

abstract class $FilterDataCopyWith<$Res> {
  factory $FilterDataCopyWith(
          FilterData value, $Res Function(FilterData) then) =
      _$FilterDataCopyWithImpl<$Res>;
  $Res call({bool abandoned, bool ongoing, bool finished, bool ended});
}

class _$FilterDataCopyWithImpl<$Res> implements $FilterDataCopyWith<$Res> {
  _$FilterDataCopyWithImpl(this._value, this._then);

  final FilterData _value;
  // ignore: unused_field
  final $Res Function(FilterData) _then;

  @override
  $Res call({
    Object abandoned = freezed,
    Object ongoing = freezed,
    Object finished = freezed,
    Object ended = freezed,
  }) {
    return _then(_value.copyWith(
      abandoned: abandoned == freezed ? _value.abandoned : abandoned as bool,
      ongoing: ongoing == freezed ? _value.ongoing : ongoing as bool,
      finished: finished == freezed ? _value.finished : finished as bool,
      ended: ended == freezed ? _value.ended : ended as bool,
    ));
  }
}

abstract class _$FilterDataCopyWith<$Res> implements $FilterDataCopyWith<$Res> {
  factory _$FilterDataCopyWith(
          _FilterData value, $Res Function(_FilterData) then) =
      __$FilterDataCopyWithImpl<$Res>;
  @override
  $Res call({bool abandoned, bool ongoing, bool finished, bool ended});
}

class __$FilterDataCopyWithImpl<$Res> extends _$FilterDataCopyWithImpl<$Res>
    implements _$FilterDataCopyWith<$Res> {
  __$FilterDataCopyWithImpl(
      _FilterData _value, $Res Function(_FilterData) _then)
      : super(_value, (v) => _then(v as _FilterData));

  @override
  _FilterData get _value => super._value as _FilterData;

  @override
  $Res call({
    Object abandoned = freezed,
    Object ongoing = freezed,
    Object finished = freezed,
    Object ended = freezed,
  }) {
    return _then(_FilterData(
      abandoned: abandoned == freezed ? _value.abandoned : abandoned as bool,
      ongoing: ongoing == freezed ? _value.ongoing : ongoing as bool,
      finished: finished == freezed ? _value.finished : finished as bool,
      ended: ended == freezed ? _value.ended : ended as bool,
    ));
  }
}

@JsonSerializable()
class _$_FilterData implements _FilterData {
  _$_FilterData(
      {this.abandoned = false,
      this.ongoing = true,
      this.finished = false,
      this.ended = true})
      : assert(abandoned != null),
        assert(ongoing != null),
        assert(finished != null),
        assert(ended != null);

  factory _$_FilterData.fromJson(Map<String, dynamic> json) =>
      _$_$_FilterDataFromJson(json);

  @JsonKey(defaultValue: false)
  @override
  final bool abandoned;
  @JsonKey(defaultValue: true)
  @override
  final bool ongoing;
  @JsonKey(defaultValue: false)
  @override
  final bool finished;
  @JsonKey(defaultValue: true)
  @override
  final bool ended;

  @override
  String toString() {
    return 'FilterData(abandoned: $abandoned, ongoing: $ongoing, finished: $finished, ended: $ended)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FilterData &&
            (identical(other.abandoned, abandoned) ||
                const DeepCollectionEquality()
                    .equals(other.abandoned, abandoned)) &&
            (identical(other.ongoing, ongoing) ||
                const DeepCollectionEquality()
                    .equals(other.ongoing, ongoing)) &&
            (identical(other.finished, finished) ||
                const DeepCollectionEquality()
                    .equals(other.finished, finished)) &&
            (identical(other.ended, ended) ||
                const DeepCollectionEquality().equals(other.ended, ended)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(abandoned) ^
      const DeepCollectionEquality().hash(ongoing) ^
      const DeepCollectionEquality().hash(finished) ^
      const DeepCollectionEquality().hash(ended);

  @override
  _$FilterDataCopyWith<_FilterData> get copyWith =>
      __$FilterDataCopyWithImpl<_FilterData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FilterDataToJson(this);
  }
}

abstract class _FilterData implements FilterData {
  factory _FilterData(
      {bool abandoned,
      bool ongoing,
      bool finished,
      bool ended}) = _$_FilterData;

  factory _FilterData.fromJson(Map<String, dynamic> json) =
      _$_FilterData.fromJson;

  @override
  bool get abandoned;
  @override
  bool get ongoing;
  @override
  bool get finished;
  @override
  bool get ended;
  @override
  _$FilterDataCopyWith<_FilterData> get copyWith;
}
