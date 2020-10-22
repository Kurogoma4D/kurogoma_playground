import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final imagePicker = ImagePicker();

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key key}) : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  String pickedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () async {
                final pickedImage =
                    await imagePicker.getImage(source: ImageSource.camera);
                setState(() {
                  pickedImagePath = pickedImage.path;
                });
              },
              child: Text('camera'),
            ),
            TextButton(
              onPressed: () async {
                final pickedImage =
                    await imagePicker.getImage(source: ImageSource.gallery);
                setState(() {
                  pickedImagePath = pickedImage.path;
                });
              },
              child: Text('gallery'),
            ),
            Text(pickedImagePath),
          ],
        ),
      ),
    );
  }
}
