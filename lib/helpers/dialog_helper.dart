import 'package:flutter/cupertino.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:pp_17/services/navigation/route_names.dart';


class DialogHelper {
  static Future<void> showNoInternetDialog(BuildContext context) async =>
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'Sorry, but it seems that you lost your internet connection. Please check your settings and try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.splash,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );

  static Future<void> showAppVersionDialog(BuildContext context) async {
    final info = AppInfo.of(context);
    await showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text(info.package.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Operating system: ${info.platform.operatingSystem}'),
            const SizedBox(height: 8),
            Text('Installer store: ${info.package.installerStore ?? '-'}'),
            const SizedBox(height: 8),
            Text('Version: ${info.package.versionWithoutBuild}'),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: Navigator.of(context).pop,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}