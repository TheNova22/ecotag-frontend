import 'dart:convert';

class Manufacturer {
  final String id;
  final String company;
  final String address;
  final String phone;
  final double lat;
  final double lng;
  final double score;
  Manufacturer({
    required this.id,
    required this.company,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.score,
  });

  Manufacturer copyWith({
    String? id,
    String? company,
    String? address,
    String? phone,
    double? lat,
    double? lng,
    double? score,
  }) {
    return Manufacturer(
      id: id ?? this.id,
      company: company ?? this.company,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company': company,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'score': score,
    };
  }

  factory Manufacturer.fromMap(Map<String, dynamic> map) {
    return Manufacturer(
      id: map['_id'] ?? '',
      company: map['company'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      score: map['score']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manufacturer.fromJson(String source) =>
      Manufacturer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Manufacturer(id: $id, company: $company, address: $address, phone: $phone, lat: $lat, lng: $lng, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Manufacturer &&
        other.id == id &&
        other.company == company &&
        other.address == address &&
        other.phone == phone &&
        other.lat == lat &&
        other.lng == lng &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        company.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        score.hashCode;
  }
}

// [{"_id": "ccc", "company": "XYZ Speaker Maker", "lat": 333.213, "long": 123.1422, "address": "Central Kolkata, Kolkata,
// India", "phone": "+91358359938", "score": 0.6666666666666666},

//  {"_id": "bbb", "company": "ABC Speaker Maker", "lat":
// 333.213, "long": 123.1422, "address": "Central Kolkata, Kolkata, India", "phone": "+91358359938", "products": ["zxcv",
// "qwytu"], "score": 0.6666666666666666}, {"_id": "aaa", "company": "ABC Mixer Maker", "lat": 333.213, "long": 123.1422,
// "address": "Central Kolkata, Kolkata, India", "phone": "+91358359938", "products": ["qweqwr", "sdff"],
// "currentShipments": [{"$oid": "62fbb548a50b825369f2d8ab"}, {"$oid": "62fbb78b572ecda674871d10"}, {"$oid":
// "62fbb80e572ecda674871d11"}, {"$oid": "62fbb8ce29ae383902386de7"}, {"$oid": "62fbb94abb2ca90a99396e00"}, {"$oid":
// "62fbb9e334d0628d6f9e1fde"}, {"$oid": "62fbba53bad3f183e0f6fb00"}], "score": 0.6666666666666666}]