import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/image/image_helper.dart';
import '../../services/navigation/route_names.dart';
import '../../services/storage/storage_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _storageService = GetIt.instance<StorageService>();

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => _navigate());
    super.initState();
  }

  void _navigate() {
    final isFirstLaunch =
        _storageService.getBool(StorageKeys.isFirstLaunch) ?? true;
    if (isFirstLaunch) {
      _storageService.setBool(StorageKeys.isFirstLaunch, false);
      Navigator.of(context).popAndPushNamed(RouteNames.onboarding);
    } else {
      Navigator.of(context).popAndPushNamed(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ImageHelper.getImage(ImageNames.splash).image,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 270),
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
