import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Supplier {
  final String image_url;
  final String product_title;
  final String manufacturer_name;
  final String manufacturer_address;
  final String product_link;
  final double distance;
  final double lat;
  final double lng;
  final String price;
  Supplier({
    required this.image_url,
    required this.product_title,
    required this.manufacturer_name,
    required this.manufacturer_address,
    required this.product_link,
    required this.distance,
    required this.lat,
    required this.lng,
    required this.price,
  });

  Supplier copyWith({
    String? image_url,
    String? product_title,
    String? manufacturer_name,
    String? manufacturer_address,
    String? product_link,
    double? distance,
    double? lat,
    double? lng,
    String? price,
  }) {
    return Supplier(
      image_url: image_url ?? this.image_url,
      product_title: product_title ?? this.product_title,
      manufacturer_name: manufacturer_name ?? this.manufacturer_name,
      manufacturer_address: manufacturer_address ?? this.manufacturer_address,
      product_link: product_link ?? this.product_link,
      distance: distance ?? this.distance,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image_url': image_url,
      'product_title': product_title,
      'manufacturer_name': manufacturer_name,
      'manufacturer_address': manufacturer_address,
      'product_link': product_link,
      'distance': distance,
      'lat': lat,
      'lng': lng,
      'price': price,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      image_url: map['image_url'] ?? '',
      product_title: map['product_title'] ?? '',
      manufacturer_name: map['manufacturer_name'] ?? '',
      manufacturer_address: map['manufacturer_address'] ?? '',
      product_link: map['product_link'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Supplier.fromJson(String source) =>
      Supplier.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Supplier(image_url: $image_url, product_title: $product_title, manufacturer_name: $manufacturer_name, manufacturer_address: $manufacturer_address, product_link: $product_link, distance: $distance, lat: $lat, lng: $lng, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Supplier &&
        other.image_url == image_url &&
        other.product_title == product_title &&
        other.manufacturer_name == manufacturer_name &&
        other.manufacturer_address == manufacturer_address &&
        other.product_link == product_link &&
        other.distance == distance &&
        other.lat == lat &&
        other.lng == lng &&
        other.price == price;
  }

  @override
  int get hashCode {
    return image_url.hashCode ^
        product_title.hashCode ^
        manufacturer_name.hashCode ^
        manufacturer_address.hashCode ^
        product_link.hashCode ^
        distance.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        price.hashCode;
  }
}
