import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';

class NewsController extends ChangeNotifier {
  final _newsService = GetIt.instance<NewsApiService>();
  List<Map<String, dynamic>> newsList = [];
  bool isLoading = true;

  Future<void> fetchNews() async {
    try {
      final result = await _newsService.getNews('Europe');
      newsList = result;
    } catch (error) {
      print('Error: $error');
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
