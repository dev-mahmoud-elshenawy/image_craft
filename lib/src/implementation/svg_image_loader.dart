import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_craft/image_craft.dart';

/// A concrete implementation of [ImageLoader] that loads SVG images from assets.
///
/// The `SvgImageLoader` class extends the [ImageLoader] abstract class
/// and provides functionality to load SVG images from the application's asset bundle.
///
/// ## Method:
///
/// - `Future<Widget> loadImage({...})`:
///   - Loads an SVG image from the specified asset path.
///   - **Parameters**:
///     - `path`: A [String] representing the asset path of the SVG image to load.
///     - `fit`: A [BoxFit] value that determines how the image should
///       be resized to fit its container.
///     - `width`: A [double] representing the desired width of the image.
///     - `height`: A [double] representing the desired height of the image.
///     - `placeholder`: An optional [Widget] to be displayed while the
///       image is loading. Defaults to null if not provided.
///     - `errorWidget`: An optional [Widget] to be displayed if the
///       image fails to load. Defaults to null if not provided.
///   - **Returns**: A [Future<Widget>] that resolves to a widget displaying
///     the loaded SVG image, or a placeholder/error widget as applicable.
///   - **Example**:
///     ```dart
///     Widget svgWidget = await svgImageLoader.loadImage(
///       path: 'assets/images/icon.svg',
///       fit: BoxFit.cover,
///       width: 100.0,
///       height: 100.0,
///       placeholder: CircularProgressIndicator(),
///       errorWidget: Text('Failed to load SVG'),
///     );
///     ```
///
/// ## Error Handling:
///
/// If the SVG image cannot be loaded from the specified asset path,
/// the method will return the specified `errorWidget` or an `ErrorPlaceholder`
/// widget if no error widget is provided.
class SvgImageLoader extends ImageLoader {
  /// Loads an SVG image from the specified asset path.
  ///
  /// **Parameters**:
  /// - [path]: A [String] representing the asset path of the SVG image to load.
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
  /// the loaded SVG image, or a placeholder/error widget as applicable.
  ///
  /// **Example**:
  /// ```dart
  /// Widget svgWidget = await svgImageLoader.loadImage(
  ///   path: 'assets/images/icon.svg',
  ///   fit: BoxFit.cover,
  ///   width: 100.0,
  ///   height: 100.0,
  ///   placeholder: CircularProgressIndicator(),
  ///   errorWidget: Text('Failed to load SVG'),
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
    try {
      // Load the SVG image from the specified asset path
      return SvgPicture.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    } catch (e) {
      // If an error occurs, return the error widget
      return errorWidget ?? PlaceholderManager.getErrorPlaceholder();
    }
  }
}
