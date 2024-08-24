import 'package:image_craft/image_craft.dart';

class ImageLoaderFactory {
  static ImageLoader getImageLoader(ImageType imageType) {
    switch (imageType) {
      case ImageType.NETWORK:
        return NetworkImageLoader();
      case ImageType.ASSET:
        return AssetImageLoader();
      case ImageType.SVG:
        return SvgImageLoader();
      case ImageType.FILE:
        return FileImageLoader();
      default:
        throw UnsupportedError('Unsupported image type');
    }
  }
}
