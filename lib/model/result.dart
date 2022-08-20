import 'dart:convert';

class Result {
  final String mode;
  final String from;
  final String to;
  final double initalToPort1_distance;
  final double initalToPort1_emission;
  final double port1ToPort2_distance;
  final double port1ToPort2_emission;
  final double port2ToFinal_distance;
  final double port2ToFinal_emission;
  final double emission;
  Result({
    required this.mode,
    required this.from,
    required this.to,
    required this.initalToPort1_distance,
    required this.initalToPort1_emission,
    required this.port1ToPort2_distance,
    required this.port1ToPort2_emission,
    required this.port2ToFinal_distance,
    required this.port2ToFinal_emission,
    required this.emission,
  });

  Result copyWith({
    String? mode,
    String? from,
    String? to,
    double? initalToPort1_distance,
    double? initalToPort1_emission,
    double? port1ToPort2_distance,
    double? port1ToPort2_emission,
    double? port2ToFinal_distance,
    double? port2ToFinal_emission,
    double? emission,
  }) {
    return Result(
      mode: mode ?? this.mode,
      from: from ?? this.from,
      to: to ?? this.to,
      initalToPort1_distance:
          initalToPort1_distance ?? this.initalToPort1_distance,
      initalToPort1_emission:
          initalToPort1_emission ?? this.initalToPort1_emission,
      port1ToPort2_distance:
          port1ToPort2_distance ?? this.port1ToPort2_distance,
      port1ToPort2_emission:
          port1ToPort2_emission ?? this.port1ToPort2_emission,
      port2ToFinal_distance:
          port2ToFinal_distance ?? this.port2ToFinal_distance,
      port2ToFinal_emission:
          port2ToFinal_emission ?? this.port2ToFinal_emission,
      emission: emission ?? this.emission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mode': mode,
      'from': from,
      'to': to,
      'initalToPort1_distance': initalToPort1_distance,
      'initalToPort1_emission': initalToPort1_emission,
      'port1ToPort2_distance': port1ToPort2_distance,
      'port1ToPort2_emission': port1ToPort2_emission,
      'port2ToFinal_distance': port2ToFinal_distance,
      'port2ToFinal_emission': port2ToFinal_emission,
      'emission': emission,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      mode: map['mode'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      initalToPort1_distance: map['initalToPort1_distance']?.toDouble() ?? 0.0,
      initalToPort1_emission: map['initalToPort1_emission']?.toDouble() ?? 0.0,
      port1ToPort2_distance: map['port1ToPort2_distance']?.toDouble() ?? 0.0,
      port1ToPort2_emission: map['port1ToPort2_emission']?.toDouble() ?? 0.0,
      port2ToFinal_distance: map['port2ToFinal_distance']?.toDouble() ?? 0.0,
      port2ToFinal_emission: map['port2ToFinal_emission']?.toDouble() ?? 0.0,
      emission: map['emission']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(mode: $mode, from: $from, to: $to, initalToPort1_distance: $initalToPort1_distance, initalToPort1_emission: $initalToPort1_emission, port1ToPort2_distance: $port1ToPort2_distance, port1ToPort2_emission: $port1ToPort2_emission, port2ToFinal_distance: $port2ToFinal_distance, port2ToFinal_emission: $port2ToFinal_emission, emission: $emission)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.mode == mode &&
        other.from == from &&
        other.to == to &&
        other.initalToPort1_distance == initalToPort1_distance &&
        other.initalToPort1_emission == initalToPort1_emission &&
        other.port1ToPort2_distance == port1ToPort2_distance &&
        other.port1ToPort2_emission == port1ToPort2_emission &&
        other.port2ToFinal_distance == port2ToFinal_distance &&
        other.port2ToFinal_emission == port2ToFinal_emission &&
        other.emission == emission;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        from.hashCode ^
        to.hashCode ^
        initalToPort1_distance.hashCode ^
        initalToPort1_emission.hashCode ^
        port1ToPort2_distance.hashCode ^
        port1ToPort2_emission.hashCode ^
        port2ToFinal_distance.hashCode ^
        port2ToFinal_emission.hashCode ^
        emission.hashCode;
  }
}
