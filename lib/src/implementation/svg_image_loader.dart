import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_craft/image_craft.dart';

class SvgImageLoader extends ImageLoader {
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
      return SvgPicture.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    } catch (e) {
      return errorWidget ?? ErrorPlaceholder();
    }
  }
}
