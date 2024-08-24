import 'package:flutter/material.dart';

/// An abstract class that defines a contract for loading images.
///
/// The `ImageLoader` class serves as a blueprint for concrete image
/// loader implementations, such as loading images from network,
/// assets, files, or SVG formats. Any class that extends `ImageLoader`
/// must implement the `loadImage` method, providing the specific
/// logic for loading images.
///
/// ## Method:
///
/// - `Future<Widget> loadImage({...})`:
///   - Loads an image based on the provided parameters and returns a
///     widget that displays the loaded image.
///   - **Parameters**:
///     - `path`: A [String] representing the path or URL of the image to load.
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
///     Widget imageWidget = await imageLoader.loadImage(
///       path: 'https://example.com/image.png',
///       fit: BoxFit.cover,
///       width: 200.0,
///       height: 100.0,
///       placeholder: CircularProgressIndicator(),
///       errorWidget: Text('Failed to load image'),
///     );
///     ```
///
/// ## Note:
///
/// This class is intended to be subclassed, and the specific logic for
/// loading images should be implemented in the subclasses. Each
/// implementation can handle different image sources and error
/// handling mechanisms as necessary.
abstract class ImageLoader {
  /// Loads an image based on the provided parameters and returns a
  /// widget that displays the loaded image.
  ///
  /// **Parameters**:
  /// - [path]: A [String] representing the path or URL of the image to load.
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
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  });
}