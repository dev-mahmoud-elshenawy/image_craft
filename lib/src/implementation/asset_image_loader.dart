import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_craft/image_craft.dart';

/// A concrete implementation of [ImageLoader] that loads images from
/// the asset bundle.
///
/// The `AssetImageLoader` class extends the [ImageLoader] abstract
/// class and implements the `loadImage` method to retrieve images
/// stored in the application's asset bundle. It utilizes Flutter's
/// `rootBundle` to access the asset data and return it as an image
/// widget.
///
/// ## Method:
///
/// - `Future<Widget> loadImage({...})`:
///   - Loads an image from the asset bundle and returns a widget
///     displaying the image.
///   - **Parameters**:
///     - `path`: A [String] representing the path of the image asset
///       to load (e.g., 'assets/images/example.png').
///     - `fit`: A [BoxFit] value that determines how the image should
///       be resized to fit its container.
///     - `width`: A [double] representing the desired width of the image.
///     - `height`: A [double] representing the desired height of the image.
///     - `placeholder`: An optional [Widget] to be displayed while the
///       image is loading. Defaults to null if not provided.
///     - `errorWidget`: An optional [Widget] to be displayed if the
///       image fails to load. Defaults to null if not provided.
///   - **Returns**: A [Future<Widget>] that resolves to a widget displaying
///     the loaded image or the placeholder/error widget as applicable.
///   - **Example**:
///     ```dart
///     Widget imageWidget = await assetImageLoader.loadImage(
///       path: 'assets/images/example.png',
///       fit: BoxFit.cover,
///       width: 200.0,
///       height: 100.0,
///       placeholder: CircularProgressIndicator(),
///       errorWidget: Text('Failed to load image'),
///     );
///     ```
///
/// ## Error Handling:
///
/// If an error occurs while loading the image (e.g., the asset path is
/// invalid), the method will return the specified `errorWidget` or an
/// `ErrorPlaceholder` widget if no error widget is provided.
class AssetImageLoader extends ImageLoader {
  /// Loads an image from the asset bundle and returns a widget displaying
  /// the image.
  ///
  /// **Parameters**:
  /// - [path]: A [String] representing the path of the image asset to load.
  /// - [fit]: A [BoxFit] value that determines how the image should
  ///   be resized to fit its container.
  /// - [width]: A [double] representing the desired width of the image.
  /// - [height]: A [double] representing the desired height of the image.
  /// - [placeholder]: An optional [Widget] to be displayed while the
  ///   image is loading. Defaults to null if not provided.
  /// - [errorWidget]: An optional [Widget] to be displayed if the
  ///   image fails to load. Defaults to null if not provided.
  ///
  /// **Returns**: A [Future<Widget>] that resolves to a widget displaying
  /// the loaded image or the placeholder/error widget as applicable.
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
      // Load image data from the asset bundle
      final ByteData data = await rootBundle.load(path);
      // Return an Image widget created from the asset data
      return Image.memory(
        data.buffer.asUint8List(),
        fit: fit,
        width: width,
        height: height,
      );
    } catch (e) {
      // If an error occurs, return the error widget or a default placeholder
      return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
    }
  }
}
