import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class ImageCraft extends StatelessWidget {
  final String path;
  final ImageType imageType;
  final BoxFit fit;
  final double width;
  final double height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool preCacheAssets;

  const ImageCraft({
    super.key,
    required this.path,
    required this.imageType,
    this.fit = BoxFit.cover,
    this.width = 100.0,
    this.height = 100.0,
    this.placeholder,
    this.errorWidget,
    this.preCacheAssets = true,
  });

  @override
  Widget build(BuildContext context) {
    final loader = ImageLoaderFactory.getImageLoader(imageType);

    if (preCacheAssets && imageType == ImageType.ASSET) {
      CacheManager().preCacheAsset(path);
    }

    return FutureBuilder<Widget>(
      future: loader.loadImage(
        path: path,
        fit: fit,
        width: width,
        height: height,
        placeholder: placeholder,
        errorWidget: errorWidget,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return errorWidget ?? ErrorPlaceholder();
        } else {
          return placeholder ?? LoadingPlaceholder();
        }
      },
    );
  }
}
