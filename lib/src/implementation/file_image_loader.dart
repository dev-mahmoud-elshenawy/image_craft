import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

/// A concrete implementation of [ImageLoader] that loads images from the local file system.
///
/// The `FileImageLoader` class extends the [ImageLoader] abstract class and implements
/// the `loadImage` method to retrieve images stored in the local file system.
/// It utilizes the [CacheManager] to manage caching and the [ImageDecoder] to decode
/// images for rendering.
///
/// ## Constructor:
///
/// - `FileImageLoader({CacheManager? cacheManager, ImageDecoder? imageDecoder})`:
///   - **Parameters**:
///     - `cacheManager`: An optional instance of [CacheManager] to handle
///       local file caching. If not provided, a default instance will be created.
///     - `imageDecoder`: An optional instance of [ImageDecoder] to handle image
///       decoding. If not provided, a default instance will be created.
///
/// ## Method:
///
/// - `Future<Widget> loadImage({...})`:
///   - Loads an image from the local file system and returns a widget
///     displaying the image.
///   - **Parameters**:
///     - `path`: A [String] representing the path of the image file to load.
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
///     Widget imageWidget = await fileImageLoader.loadImage(
///       path: '/path/to/image.png',
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
/// If the specified file does not exist, the method will return the specified
/// `errorWidget` or an `ErrorPlaceholder` widget if no error widget is provided.
class FileImageLoader extends ImageLoader {
  /// The cache manager instance used for handling cached images.
  final CacheManager cacheManager;

  /// The image decoder instance used for decoding image files.
  final ImageDecoder imageDecoder;

  /// Creates a [FileImageLoader] instance with optional cache manager and
  /// image decoder.
  ///
  /// **Parameters**:
  /// - [cacheManager]: An optional instance of [CacheManager]. If null, a
  ///   default instance will be created.
  /// - [imageDecoder]: An optional instance of [ImageDecoder]. If null, a
  ///   default instance will be created.
  FileImageLoader({
    CacheManager? cacheManager,
    ImageDecoder? imageDecoder,
  })  : cacheManager = cacheManager ?? CacheManager(),
        imageDecoder = imageDecoder ?? ImageDecoder();

  /// Loads an image from the local file system and returns a widget displaying
  /// the image.
  ///
  /// **Parameters**:
  /// - [path]: A [String] representing the path of the image file to load.
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
  ///
  /// **Example**:
  /// ```dart
  /// Widget imageWidget = await fileImageLoader.loadImage(
  ///   path: '/path/to/image.png',
  ///   fit: BoxFit.cover,
  ///   width: 200.0,
  ///   height: 100.0,
  ///   placeholder: CircularProgressIndicator(),
  ///   errorWidget: Text('Failed to load image'),
  /// );
  /// ```
  @override
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  }) async {
    // Retrieve the local file using the cache manager
    final file = await cacheManager.getLocalFile(path);
    if (file.existsSync()) {
      // Load the image from the file using the image decoder
      return imageDecoder.loadImageFromFile(file, fit, width, height);
    } else {
      // If the file does not exist, return the error widget or a default placeholder
      return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
    }
  }
}
