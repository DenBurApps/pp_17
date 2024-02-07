import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_17/helpers/dialog_helper.dart';
import 'package:pp_17/services/navigation/route_names.dart';
import 'package:pp_17/services/remote_config_service.dart';
import 'package:pp_17/services/storage/storage_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



void main() => runApp(const MaterialApp(home: PrivacyAgreementView()));

class PrivacyAgreementView extends StatefulWidget {
  const PrivacyAgreementView({super.key});

  @override
  State<PrivacyAgreementView> createState() => _PrivacyAgreementViewState();
}

class _PrivacyAgreementViewState extends State<PrivacyAgreementView> {
  late final WebViewController _controller;
  final _storageService = GetIt.I<StorageService>();
  final _remoteConfig = GetIt.I<RemoteConfigService>();

  var isLoading = true;
  var agreeButton = false;

  String get _cssCode {
    if (Platform.isAndroid) {
      return """
        .docs-ml-promotion { 
          display: none !important; 
        } 
        #docs-ml-header-id {
          display: none !important;
        }
        .app-container { 
          margin: 0 !important; 
        }
      """;
    }
    return ".docs-ml-promotion, #docs-ml-header-id { display: none !important; } .app-container { margin: 0 !important; }";
  }

  String get _jsCode => """
      var style = document.createElement('style');
      style.type = "text/css";
      style.innerHTML = "$_cssCode";
      document.head.appendChild(style);
    """;

  bool _parseShowAgreeButton(String input) =>
      input.contains('showAgreebutton') || input.contains('showAgreeButton');

  @override
  void initState() {
    super.initState();

    final privacyLink = _remoteConfig.getString(ConfigKey.privacyLink);
    setState(() => agreeButton = _parseShowAgreeButton(privacyLink));

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          
          onProgress: (int progress) {
            log('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            controller.runJavaScript(_jsCode);
            log('Page finished loading: $url');
            setState(() => isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            log('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
            if (error.errorCode == -1009) {
              DialogHelper.showNoInternetDialog(context);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('showAgreebutton')) {
              setState(() => agreeButton = true);
            }
            log('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            log('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(privacyLink));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          agreeButton ? Colors.white : Theme.of(context).colorScheme.background,
      body: isLoading
          ? const  Center(
            child: CupertinoActivityIndicator(),
          )
          : SafeArea(
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (agreeButton)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                                  BoxConstraints constraints) =>
                              SizedBox(
                            width: constraints.maxWidth * 0.9,
                            height: 60,
                            child: ElevatedButton(
                        onPressed: _accept, 
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.surface,
                            onPrimary: Theme.of(context).colorScheme.primary,
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        child: const Text('Agree with privacy'),
                      ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  void _accept() {
    _storageService.setBool(StorageKeys.acceptedPrivacy, true);
    Navigator.of(context).pushReplacementNamed(RouteNames.onboarding);
  }
}