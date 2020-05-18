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

  fetchStatesLength() async {
    return apiClient.fetchStatesLengthData();
  }

  fetchStatesDailyData() async {
    return apiClient.fetchStatesDailyData();
  }

  fetchStatesDailyDataLength() async {
    return apiClient.fetchStatesDailyDataLength();
  }

  fetchZoneData() async {
    return apiClient.fetchZoneData();
  }

  fetchZoneDataLength() async {
    return apiClient.fetchZoneDataLength();
  }
}
