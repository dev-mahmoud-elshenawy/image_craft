import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

/// A class responsible for decoding images from file sources.
///
/// The `ImageDecoder` provides functionality to read and decode image
/// files into a format suitable for rendering in Flutter applications.
/// This class handles both the decoding process and the construction
/// of widgets to display the decoded images.
///
/// ## Methods:
///
/// - `Future<ui.Image> decodeImage(File file)`:
///   - Decodes an image from the specified file into a `ui.Image` object.
///   - **Parameters**:
///     - `file`: A [File] object representing the image file to decode.
///   - **Returns**: A [Future<ui.Image>] that resolves to the decoded image.
///   - **Example**:
///     ```dart
///     ui.Image decodedImage = await imageDecoder.decodeImage(myImageFile);
///     ```
///
/// - `Widget loadImageFromFile(File file, BoxFit fit, double width, double height)`:
///   - Loads an image from the specified file and returns a widget
///     displaying the image.
///   - Uses a [FutureBuilder] to handle the asynchronous image decoding
///     process and display a loading indicator while the image is being
///     decoded.
///   - **Parameters**:
///     - `file`: A [File] object representing the image file to load.
///     - `fit`: A [BoxFit] value that defines how the image should be
///       fitted into the given width and height.
///     - `width`: A [double] specifying the desired width of the image.
///     - `height`: A [double] specifying the desired height of the image.
///   - **Returns**: A [Widget] that displays the image or a loading
///     indicator/error placeholder if applicable.
///   - **Example**:
///     ```dart
///     Widget imageWidget = imageDecoder.loadImageFromFile(myImageFile, BoxFit.cover, 100.0, 100.0);
///     ```
///
/// ## Usage Example:
///
/// Here is an example of how to use the `ImageDecoder` class to decode
/// and display an image in a Flutter application:
///
/// ```dart
/// void main() {
///   final imageDecoder = ImageDecoder();
///   final imageFile = File('path/to/image.png');
///   runApp(MaterialApp(
///     home: Scaffold(
///       body: imageDecoder.loadImageFromFile(imageFile, BoxFit.cover, 300.0, 300.0),
///     ),
///   ));
/// }
/// ```
///
/// ## Note:
///
/// Ensure that the app has the necessary permissions to read files
/// from the file system, especially when running on different platforms
/// (Android, iOS, etc.).
class ImageDecoder {
  /// Decodes an image from the specified [file] into a [ui.Image] object.
  ///
  /// This method reads the file as bytes and then decodes the bytes
  /// into a Flutter [ui.Image] object. It uses a [Completer] to handle
  /// the asynchronous decoding process.
  ///
  /// **Parameters**:
  /// - [file]: A [File] object representing the image file to decode.
  ///
  /// **Returns**: A [Future<ui.Image>] that resolves to the decoded image.
  Future<ui.Image> decodeImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  /// Loads an image from the specified [file] and returns a widget
  /// displaying the image.
  ///
  /// This method uses a [FutureBuilder] to handle the asynchronous
  /// image decoding process and displays a loading indicator while
  /// the image is being decoded. If an error occurs during decoding,
  /// an error placeholder widget is returned.
  ///
  /// **Parameters**:
  /// - [file]: A [File] object representing the image file to load.
  /// - [fit]: A [BoxFit] value that defines how the image should be
  ///   fitted into the given width and height.
  /// - [width]: A [double] specifying the desired width of the image.
  /// - [height]: A [double] specifying the desired height of the image.
  ///
  /// **Returns**: A [Widget] that displays the image or a loading
  /// indicator/error placeholder if applicable.
  Widget loadImageFromFile(
    File file,
    BoxFit fit,
    double width,
    double height,
  ) {
    return FutureBuilder<ui.Image>(
      future: decodeImage(file),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return RawImage(
            image: snapshot.data!,
            fit: fit,
            width: width,
            height: height,
          );
        } else if (snapshot.hasError) {
          return PlaceholderManager.getErrorPlaceholder();
        } else {
          return PlaceholderManager.getLoadingPlaceholder();
        }
      },
    );
  }
}
