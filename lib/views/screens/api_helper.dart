import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../modal/covid.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  final String api = "https://disease.sh/v3/covid-19/countries";

  Future<List<COVIDData>?> fetchCovidData() async {
    http.Response res = await http.get(
      Uri.parse(api),
    );

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<COVIDData> covidData = decodedData.map((e) {
        return COVIDData.fromMap(data: e);
      }).toList();
      return covidData;
    }
    return null;
  }
}
