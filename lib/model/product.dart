import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String image_url;
  final List<String> category;
  final String categoryID;
  final List<String> manufacturer;
  final String name;
  final double rating;
  final double totalEmission;
  final int totalManufacturers;
  final double score;
  Product({
    required this.id,
    required this.image_url,
    required this.category,
    required this.categoryID,
    required this.manufacturer,
    required this.name,
    required this.rating,
    required this.totalEmission,
    required this.totalManufacturers,
    required this.score,
  });

  Product copyWith({
    String? id,
    String? image_url,
    List<String>? category,
    String? categoryID,
    List<String>? manufacturer,
    String? name,
    double? rating,
    double? totalEmission,
    int? totalManufacturers,
    double? score,
  }) {
    return Product(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      category: category ?? this.category,
      categoryID: categoryID ?? this.categoryID,
      manufacturer: manufacturer ?? this.manufacturer,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      totalEmission: totalEmission ?? this.totalEmission,
      totalManufacturers: totalManufacturers ?? this.totalManufacturers,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'image_url': image_url,
      'category': category,
      'categoryID': categoryID,
      'manufacturer': manufacturer,
      'name': name,
      'rating': rating,
      'totalEmission': totalEmission,
      'totalManufacturers': totalManufacturers,
      'score': score,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      image_url: map['image_url'] ?? '',
      category: List<String>.from(map['category']),
      categoryID: map['categoryID'] ?? '',
      manufacturer: List<String>.from(map['manufacturer']),
      name: map['name'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      totalEmission: map['totalEmission']?.toDouble() ?? 0.0,
      totalManufacturers: map['totalManufacturers']?.toInt() ?? 0,
      score: map['score']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, image_url: $image_url, category: $category, categoryID: $categoryID, manufacturer: $manufacturer, name: $name, rating: $rating, totalEmission: $totalEmission, totalManufacturers: $totalManufacturers, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.image_url == image_url &&
        listEquals(other.category, category) &&
        other.categoryID == categoryID &&
        listEquals(other.manufacturer, manufacturer) &&
        other.name == name &&
        other.rating == rating &&
        other.totalEmission == totalEmission &&
        other.totalManufacturers == totalManufacturers &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image_url.hashCode ^
        category.hashCode ^
        categoryID.hashCode ^
        manufacturer.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        totalEmission.hashCode ^
        totalManufacturers.hashCode ^
        score.hashCode;
  }
}
