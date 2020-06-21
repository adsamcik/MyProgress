import 'package:myprogress/data/storage/abstraction/storable.dart';
import 'package:flutter/foundation.dart';

class MockStorable implements Storable<String> {
  @override
  String key;

  String value;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MockStorable({
    @required this.key,
    @required this.value,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MockStorable && runtimeType == other.runtimeType && key == other.key && value == other.value);

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'MockStorable{ key: $key, value: $value,}';
  }

  MockStorable copyWith({
    String key,
    String value,
  }) {
    return MockStorable(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory MockStorable.fromJson(Map<String, dynamic> map) {
    return MockStorable(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

//</editor-fold>
}
