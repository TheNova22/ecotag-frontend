import 'dart:convert';

import 'package:flutter/foundation.dart';

class Shipment {
  final Map<String, String> id;
  final String manufacturer;
  final String startLocation;
  final String pid;
  final double totalWeight;
  final double currentLat;
  final double currentLong;
  final String status;
  final Map<String, String> timestamp;
  final List<String> journey;
  final String transportMode;
  final String enroute_to;
  final double emission;
  Shipment({
    required this.id,
    required this.manufacturer,
    required this.startLocation,
    required this.pid,
    required this.totalWeight,
    required this.currentLat,
    required this.currentLong,
    required this.status,
    required this.timestamp,
    required this.journey,
    required this.transportMode,
    required this.enroute_to,
    required this.emission,
  });

  Shipment copyWith({
    Map<String, String>? id,
    String? manufacturer,
    String? startLocation,
    String? pid,
    double? totalWeight,
    double? currentLat,
    double? currentLong,
    String? status,
    Map<String, String>? timestamp,
    List<String>? journey,
    String? transportMode,
    String? enroute_to,
    double? emission,
  }) {
    return Shipment(
      id: id ?? this.id,
      manufacturer: manufacturer ?? this.manufacturer,
      startLocation: startLocation ?? this.startLocation,
      pid: pid ?? this.pid,
      totalWeight: totalWeight ?? this.totalWeight,
      currentLat: currentLat ?? this.currentLat,
      currentLong: currentLong ?? this.currentLong,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      journey: journey ?? this.journey,
      transportMode: transportMode ?? this.transportMode,
      enroute_to: enroute_to ?? this.enroute_to,
      emission: emission ?? this.emission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'manufacturer': manufacturer,
      'startLocation': startLocation,
      'pid': pid,
      'totalWeight': totalWeight,
      'currentLat': currentLat,
      'currentLong': currentLong,
      'status': status,
      'timestamp': timestamp,
      'journey': journey,
      'transportMode': transportMode,
      'enroute_to': enroute_to,
      'emission': emission,
    };
  }

  factory Shipment.fromMap(Map<String, dynamic> map) {
    return Shipment(
      id: Map<String, String>.from(map['_id']),
      manufacturer: map['manufacturer'] ?? '',
      startLocation: map['startLocation'] ?? '',
      pid: map['pid'] ?? '',
      totalWeight: map['totalWeight']?.toDouble() ?? 0.0,
      currentLat: map['currentLat']?.toDouble() ?? 0.0,
      currentLong: map['currentLong']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      timestamp: Map<String, String>.from(map['timestamp']),
      journey: List<String>.from(map['journey']),
      transportMode: map['transportMode'] ?? '',
      enroute_to: map['enroute_to'] ?? '',
      emission: map['emission']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shipment.fromJson(String source) =>
      Shipment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shipment(id: $id, manufacturer: $manufacturer, startLocation: $startLocation, pid: $pid, totalWeight: $totalWeight, currentLat: $currentLat, currentLong: $currentLong, status: $status, timestamp: $timestamp, journey: $journey, transportMode: $transportMode, enroute_to: $enroute_to, emission: $emission)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shipment &&
        mapEquals(other.id, id) &&
        other.manufacturer == manufacturer &&
        other.startLocation == startLocation &&
        other.pid == pid &&
        other.totalWeight == totalWeight &&
        other.currentLat == currentLat &&
        other.currentLong == currentLong &&
        other.status == status &&
        mapEquals(other.timestamp, timestamp) &&
        listEquals(other.journey, journey) &&
        other.transportMode == transportMode &&
        other.enroute_to == enroute_to &&
        other.emission == emission;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        manufacturer.hashCode ^
        startLocation.hashCode ^
        pid.hashCode ^
        totalWeight.hashCode ^
        currentLat.hashCode ^
        currentLong.hashCode ^
        status.hashCode ^
        timestamp.hashCode ^
        journey.hashCode ^
        transportMode.hashCode ^
        enroute_to.hashCode ^
        emission.hashCode;
  }
}
