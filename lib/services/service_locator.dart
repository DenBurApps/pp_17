import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/news_controller.dart';
import '/services/storage/storage_service.dart';

import 'api_service.dart';
import 'event_bus.dart';
import 'network_service.dart';

class ServiceLocator {
  final _getIt = GetIt.instance;
  Future<void> setup() async {
    final storageService = StorageService();
    _getIt.registerSingleton<StorageService>(storageService);
    await storageService.init();
    _getIt.registerSingleton<NetworkService>(NetworkService());
    _getIt.registerSingleton<EventBus>(EventBus());
    _getIt.registerSingleton<NewsApiService>(NewsApiService());
    _getIt.registerSingleton<NewsController>(NewsController());
  }
}
