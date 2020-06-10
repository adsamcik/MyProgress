// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'filter_runtime_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$FilterRuntimeDataTearOff {
  const _$FilterRuntimeDataTearOff();

  _FilterRuntimeData call(FilterData filterData, {String query = ''}) {
    return _FilterRuntimeData(
      filterData,
      query: query,
    );
  }
}

// ignore: unused_element
const $FilterRuntimeData = _$FilterRuntimeDataTearOff();

mixin _$FilterRuntimeData {
  FilterData get filterData;
  String get query;

  $FilterRuntimeDataCopyWith<FilterRuntimeData> get copyWith;
}

abstract class $FilterRuntimeDataCopyWith<$Res> {
  factory $FilterRuntimeDataCopyWith(
          FilterRuntimeData value, $Res Function(FilterRuntimeData) then) =
      _$FilterRuntimeDataCopyWithImpl<$Res>;
  $Res call({FilterData filterData, String query});

  $FilterDataCopyWith<$Res> get filterData;
}

class _$FilterRuntimeDataCopyWithImpl<$Res>
    implements $FilterRuntimeDataCopyWith<$Res> {
  _$FilterRuntimeDataCopyWithImpl(this._value, this._then);

  final FilterRuntimeData _value;
  // ignore: unused_field
  final $Res Function(FilterRuntimeData) _then;

  @override
  $Res call({
    Object filterData = freezed,
    Object query = freezed,
  }) {
    return _then(_value.copyWith(
      filterData:
          filterData == freezed ? _value.filterData : filterData as FilterData,
      query: query == freezed ? _value.query : query as String,
    ));
  }

  @override
  $FilterDataCopyWith<$Res> get filterData {
    if (_value.filterData == null) {
      return null;
    }
    return $FilterDataCopyWith<$Res>(_value.filterData, (value) {
      return _then(_value.copyWith(filterData: value));
    });
  }
}

abstract class _$FilterRuntimeDataCopyWith<$Res>
    implements $FilterRuntimeDataCopyWith<$Res> {
  factory _$FilterRuntimeDataCopyWith(
          _FilterRuntimeData value, $Res Function(_FilterRuntimeData) then) =
      __$FilterRuntimeDataCopyWithImpl<$Res>;
  @override
  $Res call({FilterData filterData, String query});

  @override
  $FilterDataCopyWith<$Res> get filterData;
}

class __$FilterRuntimeDataCopyWithImpl<$Res>
    extends _$FilterRuntimeDataCopyWithImpl<$Res>
    implements _$FilterRuntimeDataCopyWith<$Res> {
  __$FilterRuntimeDataCopyWithImpl(
      _FilterRuntimeData _value, $Res Function(_FilterRuntimeData) _then)
      : super(_value, (v) => _then(v as _FilterRuntimeData));

  @override
  _FilterRuntimeData get _value => super._value as _FilterRuntimeData;

  @override
  $Res call({
    Object filterData = freezed,
    Object query = freezed,
  }) {
    return _then(_FilterRuntimeData(
      filterData == freezed ? _value.filterData : filterData as FilterData,
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

class _$_FilterRuntimeData implements _FilterRuntimeData {
  _$_FilterRuntimeData(this.filterData, {this.query = ''})
      : assert(filterData != null),
        assert(query != null);

  @override
  final FilterData filterData;
  @JsonKey(defaultValue: '')
  @override
  final String query;

  @override
  String toString() {
    return 'FilterRuntimeData(filterData: $filterData, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FilterRuntimeData &&
            (identical(other.filterData, filterData) ||
                const DeepCollectionEquality()
                    .equals(other.filterData, filterData)) &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(filterData) ^
      const DeepCollectionEquality().hash(query);

  @override
  _$FilterRuntimeDataCopyWith<_FilterRuntimeData> get copyWith =>
      __$FilterRuntimeDataCopyWithImpl<_FilterRuntimeData>(this, _$identity);
}

abstract class _FilterRuntimeData implements FilterRuntimeData {
  factory _FilterRuntimeData(FilterData filterData, {String query}) =
      _$_FilterRuntimeData;

  @override
  FilterData get filterData;
  @override
  String get query;
  @override
  _$FilterRuntimeDataCopyWith<_FilterRuntimeData> get copyWith;
}
