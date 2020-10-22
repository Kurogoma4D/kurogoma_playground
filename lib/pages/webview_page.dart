import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WebViewPageController()),
      ],
      child: const WebViewPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenShot =
        context.select((WebViewPageController c) => c.screenShot);
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: InAppWebView(
              initialUrl: 'https://google.com',
              onWebViewCreated: (controller) => context
                  .read<WebViewPageController>()
                  .setWebViewController(controller),
            ),
          ),
          TextButton(
            child: Text('Take SS'),
            onPressed: () =>
                context.read<WebViewPageController>().takeScreenShot(),
          ),
          Flexible(
            child:
                screenShot != null ? Image.memory(screenShot) : Placeholder(),
          )
        ],
      ),
    );
  }
}

class WebViewPageController extends ChangeNotifier {
  WebViewPageController({this.locator});

  final Locator locator;
  InAppWebViewController _webViewController;
  InAppWebViewController get webViewController => _webViewController;

  Uint8List screenShot;

  void setWebViewController(InAppWebViewController instance) {
    _webViewController = instance;
  }

  void takeScreenShot() async {
    final result = await _webViewController.takeScreenshot();
    if (result == null) return;
    screenShot = result;
    notifyListeners();
  }
}
