import 'package:covid19_tracker_application/models/models.dart';
import 'package:dio/dio.dart';

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
}
