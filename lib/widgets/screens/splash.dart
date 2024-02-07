import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_17/helpers/dialog_helper.dart';
import '../../services/navigation/route_names.dart';
import '../../services/storage/storage_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _storageService = GetIt.instance<StorageService>();
  final _connectivity = Connectivity();

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    await _initConnectivity(
      () async => await DialogHelper.showNoInternetDialog(context),
    );

    _navigate();
  }

  Future<void> _initConnectivity(Future<void> Function() callback) async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        await callback.call();
        return;
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  void _navigate() {
    FlutterNativeSplash.remove();
   final acceptedPrivacy = _storageService.getBool(StorageKeys.acceptedPrivacy) ?? false;
   if (!acceptedPrivacy) {
    Navigator.of(context).pushReplacementNamed(RouteNames.privacyAgreement);
   }  else {
    final seenOnboarding = _storageService.getBool(StorageKeys.seenOnboarding) ?? false;
    if (!seenOnboarding) {
      Navigator.of(context).pushReplacementNamed(RouteNames.onboarding);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
    }
   } }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
