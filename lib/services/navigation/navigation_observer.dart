import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../network_service.dart';
import 'route_names.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final _networkService = GetIt.instance<NetworkService>();

  @override
  void didPop(Route route, Route? previousRoute) {
    final newRoute = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) async {
    final newRoute = route.settings.name;
    if (route.settings.name != RouteNames.noConnection &&
        !(await _networkService.checkConnection())) {
      route.navigator?.pushNamed(RouteNames.noConnection);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final newRouteName = newRoute?.settings.name;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
