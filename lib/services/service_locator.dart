import 'package:get_it/get_it.dart';
import 'package:pp_17/services/remote_config_service.dart';
import '../controller/news_controller.dart';
import '/services/storage/storage_service.dart';

import 'api_service.dart';
import 'event_bus.dart';
import 'network_service.dart';

class ServiceLocator {
  /// Метод установки зависимостей
  static Future<void> setup() async {
        GetIt.I.registerSingletonAsync<StorageService>(()=>StorageService().init());
        await GetIt.I.isReady<StorageService>();
    GetIt.I.registerSingletonAsync(() => RemoteConfigService().init());
    await GetIt.I.isReady<RemoteConfigService>();
    GetIt.I.registerSingleton<NetworkService>(NetworkService());

    GetIt.I.registerSingleton<EventBus>(EventBus());
    GetIt.I.registerSingleton<NewsApiService>(NewsApiService().init());
    GetIt.I.registerSingleton<NewsController>(NewsController());
  }
}
