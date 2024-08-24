import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class FileImageLoader extends ImageLoader {
  final CacheManager cacheManager;
  final ImageDecoder imageDecoder;

  FileImageLoader({
    CacheManager? cacheManager,
    ImageDecoder? imageDecoder,
  })  : cacheManager = cacheManager ?? CacheManager(),
        imageDecoder = imageDecoder ?? ImageDecoder();

  @override
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  }) async {
    final file = await cacheManager.getLocalFile(path);
    if (file.existsSync()) {
      return imageDecoder.loadImageFromFile(file, fit, width, height);
    } else {
      return errorWidget ?? ErrorPlaceholder();
    }
  }
}
