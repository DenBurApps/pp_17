import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pp_17/services/remote_config_service.dart';

class NewsApiService {
final _remoteConfigService = GetIt.instance<RemoteConfigService>();
  static const String baseUrl = 'https://google-api31.p.rapidapi.com/';
  late final String apiKey ;

  NewsApiService init() {
    apiKey = _remoteConfigService.getString(ConfigKey.newsApiKey);
    return this;
  }

  Future<List<Map<String, dynamic>>> getNews(String searchText) async {
    final Map<String, String> headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'google-api31.p.rapidapi.com',
    };

    final Map<String, dynamic> data = {
      'text': searchText,
      'region': 'wt-wt',
      'max_results': 25,
    };

    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      final List<Map<String, dynamic>> newsList = List<Map<String, dynamic>>.from(responseData['news']);
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}