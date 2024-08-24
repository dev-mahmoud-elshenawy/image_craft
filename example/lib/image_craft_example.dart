import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

void main() {
  runApp(ImageCraftApp());
}

class ImageCraftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Craft Example'),
        ),
        body: Center(
          child: ImageCraft(
            path: 'https://example.com/image.jpg', // Replace with your image URL
            imageType: ImageType.NETWORK,
            fit: BoxFit.cover,
            width: 300.0,
            height: 300.0,
            placeholder: CircularProgressIndicator(), // Placeholder while loading
            errorWidget: ErrorPlaceholder(), // Widget to display on error
            preCacheAssets: true, // Option to pre-cache assets if necessary
          ),
        ),
      ),
    );
  }
}