import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sih_frontend/model/result.dart';

class Route {
  final String source;
  final String destination;
  final List<Result> result;
  Route({
    required this.source,
    required this.destination,
    required this.result,
  });

  Route copyWith({
    String? source,
    String? destination,
    List<Result>? result,
  }) {
    return Route(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'destination': destination,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory Route.fromMap(Map<String, dynamic> map) {
    return Route(
      source: map['source'] ?? '',
      destination: map['destination'] ?? '',
      result: List<Result>.from(map['result']?.map((x) => Result.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Route.fromJson(String source) => Route.fromMap(json.decode(source));

  @override
  String toString() =>
      'Route(source: $source, destination: $destination, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Route &&
        other.source == source &&
        other.destination == destination &&
        listEquals(other.result, result);
  }

  @override
  int get hashCode => source.hashCode ^ destination.hashCode ^ result.hashCode;
}
