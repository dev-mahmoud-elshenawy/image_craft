import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

/// A [StatelessWidget] that loads and displays images from various sources.
///
/// The [ImageCraft] widget is designed to facilitate the loading of images
/// from different types of sources, such as network URLs, assets, SVGs, or
/// files. It provides customizable options for loading, error handling,
/// and display styles.
///
/// **Parameters**:
/// - [path]: A [String] representing the source path of the image. This can
///   be a network URL, asset path, or file path, depending on the [imageType].
/// - [imageType]: An [ImageType] enum value that specifies the type of image
///   to be loaded (e.g., NETWORK, ASSET, SVG, FILE).
/// - [fit]: An optional [BoxFit] parameter that defines how the image should
///   be inscribed into the allocated space. Defaults to [BoxFit.cover].
/// - [width]: An optional [double] representing the width of the image.
///   Defaults to 100.0.
/// - [height]: An optional [double] representing the height of the image.
///   Defaults to 100.0.
/// - [placeholder]: An optional [Widget] that will be displayed while the
///   image is being loaded. If not provided, a default loading indicator is used.
/// - [errorWidget]: An optional [Widget] that will be displayed if the image
///   fails to load. If not provided, a default error indicator is used.
/// - [preCacheAssets]: A [bool] indicating whether to pre-cache assets
///   before loading. Defaults to true.
///
/// **Example Usage**:
///
/// ```dart
/// ImageCraft(
///   path: 'assets/image.png',
///   imageType: ImageType.ASSET,
///   fit: BoxFit.cover,
///   placeholder: CircularProgressIndicator(),
///   errorWidget: Icon(Icons.error),
/// );
/// ```
///
/// **Behavior**:
/// When the [ImageCraft] widget is built, it determines the appropriate
/// image loader based on the provided [imageType]. If the image type is
/// ASSET and [preCacheAssets] is true, it pre-caches the asset before loading it.
/// The image loading process is handled asynchronously with a [FutureBuilder],
/// which displays the placeholder while loading and the error widget in case
/// of failure.
class ImageCraft extends StatelessWidget {
  final String path;
  final ImageType imageType;
  final BoxFit fit;
  final double width;
  final double height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool preCacheAssets;

  /// Creates an instance of [ImageCraft].
  ///
  /// **Parameters**:
  /// - [key]: An optional [Key] to uniquely identify the widget in the widget tree.
  /// - [path]: The source path of the image.
  /// - [imageType]: The type of image to be loaded.
  /// - [fit]: How the image should be inscribed into the allocated space.
  /// - [width]: The width of the image.
  /// - [height]: The height of the image.
  /// - [placeholder]: Widget to display while loading.
  /// - [errorWidget]: Widget to display in case of an error.
  /// - [preCacheAssets]: Whether to pre-cache assets.
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
      CachedManager.getInstance().preCacheAsset(path);
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
          return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
        } else {
          return placeholder ?? PlaceholderManager.getLoadingPlaceholder();
        }
      },
    );
  }
}
