import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_craft/image_craft.dart';

class NetworkImageLoader extends ImageLoader {
  final CacheManager cacheManager;

  NetworkImageLoader({
    CacheManager? cacheManager,
  }) : cacheManager = cacheManager ?? CacheManager();

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
      return Image.file(file, fit: fit, width: width, height: height);
    } else {
      return _downloadAndCacheImage(
        path,
        file,
        fit,
        width,
        height,
        placeholder,
        errorWidget,
      );
    }
  }

  Future<Widget> _downloadAndCacheImage(
      String url,
      File file,
      BoxFit fit,
      double width,
      double height,
      Widget? placeholder,
      Widget? errorWidget) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return Image.file(
          file,
          fit: fit,
          width: width,
          height: height,
        );
      } else {
        return errorWidget ?? ErrorPlaceholder();
      }
    } catch (e) {
      return errorWidget ?? ErrorPlaceholder();
    }
  }
}
