import 'package:flutter/material.dart';

abstract class ImageLoader {
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  });
}
