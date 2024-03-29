// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sih_frontend/model/inspection_form.dart';
import 'package:sih_frontend/model/manufacturer.dart';
import 'package:sih_frontend/model/product.dart';
import 'package:sih_frontend/model/result.dart';
import 'package:sih_frontend/model/route.dart' as rt;
import 'package:sih_frontend/model/shipment.dart';
import 'package:sih_frontend/model/supplier.dart';
import 'package:sih_frontend/utils/authentication.dart';

class EcoTagAPI {
  final Dio _dio = Dio();
  static const String _baseUrl = "https://back.ecotag.dev/";

  Future<Map<String, dynamic>> getProductNameByBarcode(
      {required String barcode}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProductNameByBarcode?barcode=$barcode');
    debugPrint('${userData.data}');
    showToast('${userData.data}');
    var res = userData.data;

    return res;
    // if (res["status"] == "Failed") {
    //   return {"productName": "Searching"};
    // } else {
    //   return {"productName": res["productName"].toString()};
    // }
  }

  Future<Map<String, dynamic>> getProductFromBarcode(
      {required String barcode}) async {
    Response userData =
        await _dio.get('${_baseUrl}getProduct?barcode=$barcode');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return jsonDecode(userData.data);
  }

  Future<Map<String, dynamic>> detectImage({required FormData formData}) async {
    Response resp = await _dio.post("${_baseUrl}detectImage", data: formData);
    return resp.data;
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

  Future<List<String>> predictCategories({required String searchTerm}) async {
    Response userData =
        await _dio.get('${_baseUrl}getCategories?searchTerm=$searchTerm');
    debugPrint(' ${userData.data}');
    // showToast('${userData.data}');

    return jsonDecode(userData.data).map<String>((e) => e.toString()).toList();
  }

  Future<Map<String, dynamic>> stater(String catID) async {
    Response userData =
        await _dio.get('${_baseUrl}getStates?categoryID=$catID');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return jsonDecode(userData.data);
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

  Future<List<Product>> getProductsByManufacturer({required String mid}) async {
    Response userData =
        await _dio.get("${_baseUrl}getProductFromManufacturer?mid=$mid");
    debugPrint(' ${userData.data}');
    // showToast('${userData.data}');
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

  Future<List<InspectionForm>> getInspectionForms() async {
    Response userData = await _dio.get('${_baseUrl}getInspectionForms');
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');
    return jsonDecode(userData.data)
        .map<InspectionForm>((e) => InspectionForm.fromMap(e))
        .toList();
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

    return Map<String, dynamic>.from(jsonDecode(userData.data));
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

  Future<Map<String, dynamic>> addProduct(
      {name,
      category,
      emission,
      manufacturer,
      barcode,
      rawMaterials,
      components,
      weight,
      price}) async {
    Response userData = await _dio.post('${_baseUrl}addProduct',
        data: json.encode({
          "name": name,
          "weight": weight,
          "price": price,
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

// {"manufacturer" : "XBku39MbubgRLjrK8URABRQySzP2", "inputFields" : ["How much waste?"], "inputTypes" : ["double"], "makerName" : "Gonzalez", "formName" : "How much waste is wasted?"}
  Future<Map<String, dynamic>> addForm({required InspectionForm form}) async {
    Response userData =
        await _dio.post('${_baseUrl}addInspectionForm', data: form.toJson());
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }

  Future<Map<String, dynamic>> enterFormValues(
      {required List<String> resultValues, required String formid}) async {
    //note that we should send the form id along with the form
    final data = {
      "id": formid,
      "formValues": resultValues,
    };
    Response userData =
        await _dio.post('${_baseUrl}enterFormValues', data: json.encode(data));
    debugPrint(' ${userData.data}');
    showToast('${userData.data}');

    return Map<String, dynamic>.from(userData.data);
  }

  static const Map<String, dynamic> recyclingLocations = {
    "Assam": {
      "paper": [
        "A.U. Barlaskar & Co",
        "24.770735367483493,92.81920223983637",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=24.770735367483493,92.81920223983637&locations=24.770735367483493,92.81920223983637&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ],
      "cardboard": [
        "UNITED GLOBAL TRUST",
        "26.11164061193119,91.75026524480703",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=26.11164061193119,91.75026524480703&locations=26.11164061193119,91.75026524480703&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ],
      "plastic": [
        "MIDUL PLASTIC",
        "26.783128161014755,94.58019646877123",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=26.783128161014755,94.58019646877123&locations=26.783128161014755,94.58019646877123&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ]
    },
    "Karnataka": {
      "paper": [
        "Kgn Recyclers",
        "13.037787143075223,77.60570683972125",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=13.037787143075223,77.60570683972125&locations=13.037787143075223,77.60570683972125&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ],
      "cardboard": [
        "RETURNLAB RECYCLERS PVT LTD",
        "12.981177047257525,77.60710099679426",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=12.981177047257525,77.60710099679426&locations=12.981177047257525,77.60710099679426&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ],
      "plastic": [
        "Khalibottle - Dry waste Management Service,Karnataka",
        "13.018830837762412,77.63250768390013",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&center=13.018830837762412,77.63250768390013&locations=13.018830837762412,77.63250768390013&size=@2x",
        "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x"
      ]
    }
  };
  static const List<String> recycleMaterials = [
    "paper",
    "cardboard",
    "plastic"
  ];
  static const Map<String, dynamic> recycleMaterialsInfo = {
    "paper": [
      "Waste paper is a vital ingredient of a healthy compost heap.",
      "An excellent packing material can be made with waste Paper",
      "You can use old newspapers to clean smooth surfaces like glass windows",
      "Use old papers as wrapping paper",
      "Old paper can be used also in arts and crafts projects"
    ],
    "cardboard": [
      "You can reuse cardboard boxes to store dry ingredients like sugar, salt and spices!",
      "Cardboard is an exellent material to make arts and crafts projects like photo frames and models",
      "Cardboard can easily be added to a compost pile and used for mulch and gardening.",
      "You can use Cardboard as dividers for objects in shelves and drawers",
      "Cardboard boxes make for excellent toys for pets like cats"
    ],
    "plastic": [
      "You can reuse plastic bags. Even plastic packaging can be reused to store food",
      "Plastic waste can be used as a filler for concrete and cement buildings",
      "You can reuse plastic bottles to store water",
      "Instead of throwing out pens, you can opt for fountain pens",
      "Old plastic wraps can be used as packing material"
    ]
  };
  static const List<String> tips = [
    "Reduce, reuse, and recycle. Cut down on what you throw away. Follow the three \"R's\" to conserve natural resources and landfill space.",
    "Volunteer. Volunteer for cleanups in your community. You can get involved in protecting your watershed, too.",
    "Educate. When you further your own education, you can help others understand the importance and value of our natural resources.",
    "Conserve water. The less water you use, the less runoff and wastewater that eventually end up in the ocean.",
    "Shop wisely. Buy less plastic and bring a reusable shopping bag.",
    "Use long-lasting light bulbs. Energy efficient light bulbs reduce greenhouse gas emissions. Also flip the light switch off when you leave the room!",
    "Plant a tree. Trees provide food and oxygen. They help save energy, clean the air, and help combat climate change.",
    "Don't send chemicals into our waterways. Choose non-toxic chemicals in the home and office.",
    "Bike more. Drive less.",
  ];
  static const String silcharNGOS =
      "https://www.mapquestapi.com/staticmap/v5/map?key=qAn7noSbYnqlsqntF65B3cFo1X3nb2rp&locations=24.823035408902186,92.79052457067884||24.822650372467383,92.79814417539595||24.830284427940793,92.79247934969443||24.69039794626271,92.84146204855546||24.82838992450862,92.73539937874871||24.841738912868543,92.80848282360753||24.82482279588932,92.78507488001006&size=@2x";
}
