import 'dart:async';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image;

final imagePicker = ImagePicker();
final editorKey = GlobalKey<ExtendedImageEditorState>();

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key}) : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  String pickedImagePath = '';
  Uint8List? rawImage;
  ExtendedImageMode imageMode = ExtendedImageMode.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: rawImage != null
                ? ExtendedImage.memory(
                    rawImage!,
                    extendedImageEditorKey: editorKey,
                    mode: imageMode,
                    fit: BoxFit.contain,
                  )
                : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  final pickedImage =
                      await imagePicker.getImage(source: ImageSource.camera);
                  if (pickedImage == null) return;
                  final data = await pickedImage.readAsBytes();
                  setState(() {
                    rawImage = data;
                    imageMode = ExtendedImageMode.editor;
                  });
                },
                child: Text('camera'),
              ),
              TextButton(
                onPressed: () async {
                  final pickedImage =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  if (pickedImage == null) return;
                  final data = await pickedImage.readAsBytes();
                  setState(() {
                    rawImage = data;
                    imageMode = ExtendedImageMode.editor;
                  });
                },
                child: Text('gallery'),
              ),
              TextButton(
                onPressed: () async {
                  final rect = editorKey.currentState!.getCropRect()!;

                  var sourceImage =
                      await compute(image.decodeImage, rawImage as List<int>);

                  if (sourceImage == null) return;

                  sourceImage = image.bakeOrientation(sourceImage);
                  sourceImage = image.copyCrop(
                    sourceImage,
                    rect.left.toInt(),
                    rect.top.toInt(),
                    rect.width.toInt(),
                    rect.height.toInt(),
                  );
                  if (sourceImage.width >= 500) {
                    sourceImage = image.copyResize(sourceImage, width: 500);
                  }

                  final result = await compute(image.encodePng, sourceImage);

                  setState(() {
                    imageMode = ExtendedImageMode.none;
                    rawImage = Uint8List.fromList(result);
                  });
                },
                child: Text('completeEdit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
