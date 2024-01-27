import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String baseUrl = 'https://google-api31.p.rapidapi.com/';
  static const String apiKey = 'fd27ef39b4msh8d4d74a66824eaap10bd48jsn209775895202';

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