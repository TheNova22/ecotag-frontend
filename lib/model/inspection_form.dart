import 'dart:convert';

import 'package:flutter/foundation.dart';

class InspectionForm {
  // {"manufacturer" : "XBku39MbubgRLjrK8URABRQySzP2", "inputFields" : ["How much waste?"], "inputTypes" : ["double"], "makerName" : "Gonzalez", "formName" : "How much waste is wasted?"}
  String formName;
  String makerName;
  String manufacturer;
  String id;
  List<String> inputFields;
  List<String> inputTypes;
  InspectionForm({
    required this.id,
    required this.formName,
    required this.makerName,
    required this.manufacturer,
    required this.inputFields,
    required this.inputTypes,
  });

  InspectionForm copyWith({
    String? formName,
    String? makerName,
    String? manufacturer,
    List<String>? inputFields,
    List<String>? inputTypes,
  }) {
    return InspectionForm(
      id: id ?? this.id,
      formName: formName ?? this.formName,
      makerName: makerName ?? this.makerName,
      manufacturer: manufacturer ?? this.manufacturer,
      inputFields: inputFields ?? this.inputFields,
      inputTypes: inputTypes ?? this.inputTypes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formName': formName,
      'makerName': makerName,
      'manufacturer': manufacturer,
      'inputFields': inputFields,
      'inputTypes': inputTypes,
    };
  }

  factory InspectionForm.fromMap(Map<String, dynamic> map) {
    return InspectionForm(
      id: map['_id'] ?? '',
      formName: map['formName'] ?? '',
      makerName: map['makerName'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      inputFields: List<String>.from(map['inputFields']),
      inputTypes: List<String>.from(map['inputTypes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionForm.fromJson(String source) =>
      InspectionForm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InspectionForm(formName: $formName, makerName: $makerName, manufacturer: $manufacturer, inputFields: $inputFields, inputTypes: $inputTypes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InspectionForm &&
        other.formName == formName &&
        other.makerName == makerName &&
        other.manufacturer == manufacturer &&
        listEquals(other.inputFields, inputFields) &&
        listEquals(other.inputTypes, inputTypes);
  }

  @override
  int get hashCode {
    return formName.hashCode ^
        makerName.hashCode ^
        manufacturer.hashCode ^
        inputFields.hashCode ^
        inputTypes.hashCode;
  }
}
