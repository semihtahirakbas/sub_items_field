// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class SubitemValueModel<T> {
  final T mainValue;
  final List<T> subValues;

  SubitemValueModel({required this.mainValue, required this.subValues});

  factory SubitemValueModel.initial() {
    return SubitemValueModel<T>(mainValue: '' as T, subValues: []);
  }

  SubitemValueModel<T> copyWith({
    T? mainValue,
    List<T>? subValues,
  }) {
    return SubitemValueModel<T>(
      mainValue: mainValue ?? this.mainValue,
      subValues: subValues ?? this.subValues,
    );
  }

  @override
  bool operator ==(covariant SubitemValueModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.subValues, subValues) &&
        other.mainValue == mainValue;
  }

  @override
  int get hashCode => subValues.hashCode ^ mainValue.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subValues': subValues,
      'mainValue': mainValue,
    };
  }

  @override
  String toString() =>
      'SubitemValueModel(subValues: $subValues, mainValue: $mainValue)';
}
