import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class ImageDecoder {
  Future<ui.Image> decodeImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

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
          return ErrorPlaceholder();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
