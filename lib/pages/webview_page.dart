import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as image;

final editorKey = GlobalKey<ExtendedImageEditorState>();

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
          Expanded(
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: screenShot != null,
                  child: InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: Uri.parse('https://google.com')),
                    onWebViewCreated: (controller) => context
                        .read<WebViewPageController>()
                        .setWebViewController(controller),
                  ),
                ),
                if (screenShot != null) const _ImageViewer(),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              TextButton(
                child: Text('Take SS'),
                onPressed: () =>
                    context.read<WebViewPageController>().takeScreenShot(),
              ),
              const SizedBox(width: 16),
              TextButton(
                child: Text('save'),
                onPressed: () =>
                    context.read<WebViewPageController>().saveImage(),
              ),
              const SizedBox(width: 16),
              TextButton(
                child: Text('clear'),
                onPressed: () =>
                    context.read<WebViewPageController>().clearImage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenShot =
        context.select((WebViewPageController c) => c.screenShot);
    final isProcessing =
        context.select((WebViewPageController c) => c.isProcessing);
    final imageMode = context.select((WebViewPageController c) => c.imageMode);
    return Center(
      child: isProcessing
          ? CircularProgressIndicator()
          : ExtendedImage.memory(
              screenShot,
              extendedImageEditorKey: editorKey,
              mode: imageMode,
              fit: BoxFit.contain,
              initEditorConfigHandler: (state) => EditorConfig(
                cropRectPadding: const EdgeInsets.all(0),
                cropAspectRatio: CropAspectRatios.ratio1_1,
                editorMaskColorHandler: (_, __) => Colors.black54,
                cornerColor: Colors.transparent,
              ),
            ),
    );
  }
}

class WebViewPageController extends ChangeNotifier {
  WebViewPageController({this.locator});

  final Locator locator;
  InAppWebViewController _webViewController;
  InAppWebViewController get webViewController => _webViewController;
  ExtendedImageMode imageMode = ExtendedImageMode.editor;
  bool isProcessing = false;

  Uint8List screenShot;

  void setWebViewController(InAppWebViewController instance) {
    _webViewController = instance;
  }

  void clearImage() {
    screenShot = null;
    notifyListeners();
  }

  void saveImage() async {
    isProcessing = true;
    notifyListeners();

    final rect = editorKey.currentState.getCropRect();
    final rawImage = screenShot;

    var sourceImage = await compute(image.decodeImage, rawImage);

    sourceImage = image.bakeOrientation(sourceImage);
    sourceImage = image.copyCrop(
      sourceImage,
      rect.left.toInt(),
      rect.top.toInt(),
      rect.width.toInt(),
      rect.height.toInt(),
    );

    final result = await compute(image.encodePng, sourceImage);
    screenShot = Uint8List.fromList(result);

    imageMode = ExtendedImageMode.none;
    isProcessing = false;
    notifyListeners();
  }

  void takeScreenShot() async {
    final result = await _webViewController.takeScreenshot();
    if (result == null) return;
    screenShot = result;
    imageMode = ExtendedImageMode.editor;
    notifyListeners();
  }
}
