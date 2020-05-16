import 'package:covid19_tracker_application/models/models.dart';
import 'package:flutter/material.dart';
import '../models/general_data_model.dart';
import 'repositories.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<Covid19> getAllData() async {
    return apiClient.getAllData();
  }

  fetchTotalData() async {
    return apiClient.fetchTotalData();
  }

  fetchChartData() async {
    return apiClient.fetchchartData();
  }

  fetchTestData() async {
    return apiClient.fetchTestData();
  }
}
