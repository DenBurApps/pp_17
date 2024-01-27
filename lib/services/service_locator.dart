import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import '../controller/news_controller.dart';
import '/services/storage/storage_service.dart';

import 'api_service.dart';
import 'event_bus.dart';
import 'network_service.dart';

/// Используется для настройки зависимостей с помощью пакета GetIt.
class ServiceLocator {
  final _getIt = GetIt.instance;
  /// Метод установки зависимостей
  Future<void> setup() async {
    _getIt.registerSingleton<NetworkService>(NetworkService());
    _getIt.registerSingleton<StorageService>(StorageService());
    _getIt.registerSingleton<EventBus>(EventBus());
    _getIt.registerSingleton<NewsApiService>(NewsApiService());
    _getIt.registerSingleton<NewsController>(NewsController());
  }
}
