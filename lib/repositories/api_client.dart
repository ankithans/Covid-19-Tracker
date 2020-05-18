import 'package:covid19_tracker_application/models/models.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/general_data_model.dart';

class ApiClient {
  static const url = 'https://api.covid19india.org/data.json';
  Dio _dio;
  ApiClient() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: url);
    _dio = Dio(options);
  }

  Future<Covid19> getAllData() async {
    try {
      final response = await _dio.get(url);
      return Covid19.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }

  fetchTotalData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    return json.decode(response.body);
  }

  fetchchartData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    return json.decode(response.body)['cases_time_series'];
  }

  fetchStatesLengthData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    return json.decode(response.body)['statewise'];
  }

  fetchTestData() async {
    http.Response response = await http
        .get('https://api.rootnet.in/covid19-in/stats/testing/latest');
    return json.decode(response.body);
  }

  fetchStatesDailyData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/states_daily.json');
    return json.decode(response.body);
  }

  fetchStatesDailyDataLength() async {
    http.Response response =
        await http.get('https://api.covid19india.org/states_daily.json');
    return json.decode(response.body)['states_daily'];
  }

  fetchZoneData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/zones.json');
    return json.decode(response.body);
  }

  fetchZoneDataLength() async {
    http.Response response =
        await http.get('https://api.covid19india.org/zones.json');
    return json.decode(response.body)['zones'];
  }
}
