import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
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
    return json.decode(userData.data);
  }

  Future<Map<String, String>> getProductFromBarcode(
      {required String barcode}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProduct?barcode=$barcode');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return {};
  }

  Future<Map<String, String>> getManufacturers({required String maker}) async {
    Response userData =
        await _dio.get('${_baseUrl}getManufacturers?searchTerm=$maker');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return {};
  }

  Future<Map<String, String>> getSupplierDetails(
      {required String searchTerm,
      required String latitude,
      required String longitude}) async {
    Response userData = await _dio.get(
        '${_baseUrl}getSuppliers?searchTerm=$searchTerm&latitude=$latitude&longitude=$longitude');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return {};
  }

  Future<Map<String, String>> getProductByName({required String name}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProductByName?searchTerm=$name');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return {};
  }

  Future<Map<String, String>> getCategoriesByName(
      {required String name}) async {
    Response userData =
        await _dio.get('${_baseUrl}getCategories?searchTerm=$name');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return {};
  }

  Future<Map<String, String>> addShipment(
      {required String manufacturer,
      required String startLocation,
      required String pid,
      required String totalWeight,
      required String currentLat,
      required String currentLong}) async {
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

    return {};
  }

  Future<Map<String, String>> addManufacturer(
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

    return {};
  }

  Future<Map<String, String>> updateShipment(
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

    return {};
  }

  Future<Map<String, String>> addProduct({
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

    return {};
  }
}
