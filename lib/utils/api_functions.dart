import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sih_frontend/model/manufacturer.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/model/result.dart';
import 'package:sih_frontend/model/route.dart' as rt;
import 'package:sih_frontend/model/shipment.dart';
import 'package:sih_frontend/model/supplier.dart';
import 'package:sih_frontend/utils/authentication.dart';

class EcoTagAPI {
  final Dio _dio = Dio();
  static const String _baseUrl =
      "http://cantin.centralindia.cloudapp.azure.com/";

  Future<Map<String, dynamic>> getProductNameByBarcode(
      {required String barcode}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProductNameByBarcode?barcode=$barcode');
    debugPrint('${userData.data}');
    showToast('${userData.data}');
    return jsonDecode(userData.data);
  }

  Future<Map<String, dynamic>> getProductFromBarcode(
      {required String barcode}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProduct?barcode=$barcode');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return jsonDecode(userData.data);
  }

  Future<List<dynamic>> getManufacturers({required String maker}) async {
    Response userData =
        await _dio.get('${_baseUrl}getManufacturers?searchTerm=$maker');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return jsonDecode(userData.data)
        .map<Manufacturer>((e) => Manufacturer.fromMap(e))
        .toList();
  }

  Future<Manufacturer> getManufacturer({required String mid}) async {
    Response userData = await _dio.get('${_baseUrl}getManufacturer?mid=$mid');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Manufacturer.fromMap(jsonDecode(userData.data));
  }

  Future<List<Supplier>> getSupplierDetails(
      {required String searchTerm,
      required double latitude,
      required double longitude}) async {
    Response userData = await _dio.get(
        '${_baseUrl}getSuppliers?searchTerm=$searchTerm&latitude=$latitude&longitude=$longitude');
    debugPrint(' ${userData.data}');
    // showToast('${userData.data}');

    return jsonDecode(userData.data)
        .map<Supplier>((e) => Supplier.fromMap(e))
        .toList();
  }

  Future<List<Product>> getProductByName({required String name}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProductByName?searchTerm=$name');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return jsonDecode(userData.data)
        .map<Product>((e) => Product.fromMap(e))
        .toList();
  }

  Future<Product> getProductDetailsByBarcode({required String barcode}) async {
    Response userData = await _dio
        .get('${_baseUrl}getProductDetailsByBarcode?barcode=$barcode');
    debugPrint(' ${userData.data}');
    // showToast('${userData.data}');

    return Product.fromMap(jsonDecode(userData.data));
  }

  Future<List<Shipment>> getShipments({required String manufacturer}) async {
    Response userData =
        await _dio.get('${_baseUrl}getShipments?manufacturer=$manufacturer');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');
    return jsonDecode(userData.data)
        .map<Shipment>((e) => Shipment.fromMap(e))
        .toList();
  }

  Future<List<Product>> getProductsByCategory(
      {required List<String> categories}) async {
    Response userData = await _dio.get(
        '${_baseUrl}getProductsByCategory?categories=${categories.join(",")}');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');
    return jsonDecode(userData.data)
        .map<Product>((e) => Product.fromMap(e))
        .toList();
  }

  Future<List<dynamic>> getCategoriesByName({required String name}) async {
    Response userData =
        await _dio.get('${_baseUrl}getCategories?searchTerm=$name');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return List<String>.from(jsonDecode(userData.data));
  }

  Future<rt.Route> getAllRoutes(
      {required String fromAddress, required String toAddress}) async {
    Response userData = await _dio.get(
        '${_baseUrl}getAllRoutes?fromAddress=$fromAddress&toAddress=$toAddress');
    return rt.Route.fromMap(jsonDecode(userData.data));
  }

  Future<Map<String, dynamic>> addShipment(
      {required String manufacturer,
      required String startLocation,
      required String pid,
      required double totalWeight,
      required double currentLat,
      required double currentLong}) async {
    final data = json.encode({
      "manufacturer": manufacturer,
      "startLocation": startLocation,
      "pid": pid,
      "totalWeight": totalWeight,
      "currentLat": currentLat,
      "currentLong": currentLong
    });
    Response userData = await _dio.post('${_baseUrl}addShipment', data: data);
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }

  Future<Map<String, dynamic>> addManufacturer(
      {id, company, lat, long, address, phone}) async {
    final data = json.encode({
      "_id": id,
      "company": company,
      "lat": lat,
      "long": long,
      "address": address,
      "phone": phone
    });
    Response userData =
        await _dio.post('${_baseUrl}addManufacturer', data: data);
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }

  Future<Map<String, dynamic>> updateShipment(
      {shipmentID,
      location,
      currentLat,
      currentLong,
      transportMode,
      enroute_to,
      status}) async {
    Response userData = await _dio.post('${_baseUrl}updateShipment',
        data: json.encode({
          "shipmentID": shipmentID,
          "location": location,
          "currentLat": currentLat,
          "currentLong": currentLong,
          "transportMode": transportMode,
          "enroute_to": enroute_to,
          "status": status
        }));
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }

  Future<Map<String, dynamic>> addProduct({
    name,
    category,
    emission,
    manufacturer,
    barcode,
    rawMaterials,
    components,
  }) async {
    Response userData = await _dio.post('${_baseUrl}addProduct',
        data: json.encode({
          "name": name,
          "category": category,
          "emission": emission,
          "manufacturer": manufacturer,
          "barcode": barcode,
          "rawMaterials": rawMaterials,
          "components": components
        }));
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }
}
