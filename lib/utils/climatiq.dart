// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class Climatiq {
  String API_KEY = "XWETZXQZSQ43TVPW4GVRXEJZFN4X";

  String baseURL = "https://beta3.api.climatiq.io/";

  Future<Map<String, dynamic>> getEmissions(
      String itemName, double itemWeight) async {
    Map<String, String> header = {"Authorization": "Bearer: $API_KEY"};

    // ignore: prefer_interpolation_to_compose_strings
    var req = await http.get(
        Uri.parse(
            "${baseURL}search?$itemName&results_per_page=1&unit_type=Weight"),
        headers: header);
    String activity_id = jsonDecode(req.body)["results"][0]["activity_id"];

    Map bodyMap = {
      "emission_factor": {"activity_id": activity_id},
      "parameters": {"weight": itemWeight, "weight_unit": "kg"}
    };

    var fin = await http.post(Uri.parse("${baseURL}estimate"),
        body: jsonEncode(bodyMap), headers: header);

    return jsonDecode(fin.body);
  }

  Future<Map<String, dynamic>> getEmissionsFromId(
      String activityId, double itemWeight) async {
    Map<String, String> header = {"Authorization": "Bearer: $API_KEY"};

    // ignore: prefer_interpolation_to_compose_strings

    Map bodyMap = {
      "emission_factor": {"activity_id": activityId},
      "parameters": {"weight": itemWeight, "weight_unit": "kg"}
    };

    var fin = await http.post(Uri.parse("${baseURL}estimate"),
        body: jsonEncode(bodyMap), headers: header);

    return jsonDecode(fin.body);
  }
}
// USAGE
// await Climatiq().getEmissions("Iron", 45).then((value) {
//         print(value);
//       });