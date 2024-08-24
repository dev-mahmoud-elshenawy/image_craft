import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_craft/image_craft.dart';

class AssetImageLoader extends ImageLoader {
  @override
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  }) async {
    try {
      final ByteData data = await rootBundle.load(path);
      return Image.memory(
        data.buffer.asUint8List(),
        fit: fit,
        width: width,
        height: height,
      );
    } catch (e) {
      return errorWidget ?? ErrorPlaceholder();
    }
  }
}
