import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_craft/image_craft.dart';

/// A concrete implementation of [ImageLoader] that loads images from the network.
///
/// The `NetworkImageLoader` class extends the [ImageLoader] abstract class
/// and provides functionality to fetch images from a network URL, cache them
/// locally using the [CachedManager], and display them in a widget.
///
/// ## Constructor:
///
/// - `NetworkImageLoader({CacheManager? cacheManager})`:
///   - **Parameters**:
///     - `cacheManager`: An optional instance of [CachedManager] to handle
///       local file caching. If not provided, a default instance will be created.
///
/// ## Method:
///
/// - `Future<Widget> loadImage({...})`:
///   - Loads an image from a network URL or from the local cache if available.
///   - **Parameters**:
///     - `path`: A [String] representing the URL of the image to load.
///     - `fit`: A [BoxFit] value that determines how the image should
///       be resized to fit its container.
///     - `width`: A [double] representing the desired width of the image.
///     - `height`: A [double] representing the desired height of the image.
///     - `placeholder`: An optional [Widget] to be displayed while the
///       image is loading. Defaults to null if not provided.
///     - `errorWidget`: An optional [Widget] to be displayed if the
///       image fails to load. Defaults to null if not provided.
///   - **Returns**: A [Future<Widget>] that resolves to a widget displaying
///     the loaded image, or a placeholder/error widget as applicable.
///   - **Example**:
///     ```dart
///     Widget imageWidget = await networkImageLoader.loadImage(
///       path: 'https://example.com/image.png',
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
/// If the image cannot be downloaded or the server returns an error code,
/// the method will return the specified `errorWidget` or an `ErrorPlaceholder`
/// widget if no error widget is provided.
class NetworkImageLoader extends ImageLoader {
  /// The cache manager instance used for handling cached images.
  final CachedManager cacheManager;

  /// Creates a [NetworkImageLoader] instance with an optional cache manager.
  ///
  /// **Parameters**:
  /// - [cacheManager]: An optional instance of [CachedManager]. If null, a
  ///   default instance will be created.
  NetworkImageLoader({
    CachedManager? cacheManager,
  }) : cacheManager = cacheManager ?? CachedManager.getInstance();

  /// Loads an image from a network URL or from the local cache if available.
  ///
  /// **Parameters**:
  /// - [path]: A [String] representing the URL of the image to load.
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
  /// the loaded image, or a placeholder/error widget as applicable.
  ///
  /// **Example**:
  /// ```dart
  /// Widget imageWidget = await networkImageLoader.loadImage(
  ///   path: 'https://example.com/image.png',
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
      // Load the image from the local file if it exists
      return Image.file(file, fit: fit, width: width, height: height);
    } else {
      // If the file does not exist, download it from the network
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

  /// Downloads an image from the specified URL and caches it locally.
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the image to download.
  /// - [file]: A [File] object representing the local file where the image
  ///   will be cached.
  /// - [fit]: A [BoxFit] value that determines how the image should
  ///   be resized to fit its container.
  /// - [width]: A [double] representing the desired width of the image.
  /// - [height]: A [double] representing the desired height of the image.
  /// - [placeholder]: An optional [Widget] to be displayed while the
  ///   image is downloading. Defaults to null if not provided.
  /// - [errorWidget]: An optional [Widget] to be displayed if the
  ///   image fails to download. Defaults to null if not provided.
  ///
  /// **Returns**: A [Future<Widget>] that resolves to a widget displaying
  /// the downloaded image, or a placeholder/error widget as applicable.
  Future<Widget> _downloadAndCacheImage(
      String url,
      File file,
      BoxFit fit,
      double width,
      double height,
      Widget? placeholder,
      Widget? errorWidget) async {
    try {
      // Perform the HTTP GET request to download the image
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the response is successful, write the image bytes to the local file
        await file.writeAsBytes(response.bodyBytes);
        return Image.file(
          file,
          fit: fit,
          width: width,
          height: height,
        );
      } else {
        // If the response is not successful, return the error widget
        return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
      }
    } catch (e) {
      // If an exception occurs, return the error widget
      return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
    }
  }
}
