import 'package:freezed_annotation/freezed_annotation.dart';

import 'filter_data.dart';

part 'filter_runtime_data.freezed.dart';

@freezed
abstract class FilterRuntimeData with _$FilterRuntimeData {
  factory FilterRuntimeData(FilterData filterData,
      {@Default('') String query}) = _FilterRuntimeData;
}
