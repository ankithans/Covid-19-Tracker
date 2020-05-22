import 'package:dio/dio.dart';
import 'package:covid19_tracker_application/models/topheadlinesnews/response_top_headlinews_news.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?language=hi&country=in&category=health&apiKey=24cf1985087946dbad6f46afc191cece';

  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<ResponseTopHeadlinesNews> getTopHeadlinesNews() async {
    try {
      final response = await _dio.get(_baseUrl);
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
}
