import 'package:covid19_tracker_application/models/models.dart';
import 'package:flutter/material.dart';
import 'repositories.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}) : assert(apiClient != null);
  Future<Covid19> getAllData() async {
    return apiClient.getAllData();
  }
}
