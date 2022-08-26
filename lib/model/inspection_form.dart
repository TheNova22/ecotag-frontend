import 'dart:convert';

import 'package:flutter/foundation.dart';

class InspectionForm {
  String name;
  String inspectorName;
  List<String> inputTypes;
  List<String> inputName;
  InspectionForm({
    required this.name,
    required this.inspectorName,
    required this.inputTypes,
    required this.inputName,
  });

  InspectionForm copyWith({
    String? name,
    String? inspectorName,
    List<String>? inputTypes,
    List<String>? inputName,
  }) {
    return InspectionForm(
      name: name ?? this.name,
      inspectorName: inspectorName ?? this.inspectorName,
      inputTypes: inputTypes ?? this.inputTypes,
      inputName: inputName ?? this.inputName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'inspectorName': inspectorName,
      'inputTypes': inputTypes,
      'inputName': inputName,
    };
  }

  factory InspectionForm.fromMap(Map<String, dynamic> map) {
    return InspectionForm(
      name: map['name'] ?? '',
      inspectorName: map['inspectorName'] ?? '',
      inputTypes: List<String>.from(map['inputTypes']),
      inputName: List<String>.from(map['inputName']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionForm.fromJson(String source) =>
      InspectionForm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InspectionForm(name: $name, inspectorName: $inspectorName, inputTypes: $inputTypes, inputName: $inputName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InspectionForm &&
        other.name == name &&
        other.inspectorName == inspectorName &&
        listEquals(other.inputTypes, inputTypes) &&
        listEquals(other.inputName, inputName);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        inspectorName.hashCode ^
        inputTypes.hashCode ^
        inputName.hashCode;
  }
}
