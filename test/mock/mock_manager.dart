import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';
import 'package:mockito/mockito.dart';

class MockCacheManager extends Mock implements ImageLoader {
  @override
  Future<Widget> loadImage({
    required String path,
    required BoxFit fit,
    required double width,
    required double height,
    Widget? placeholder,
    Widget? errorWidget,
  }) async {
    // Simulate a short delay to mimic image loading
    await Future.delayed(Duration(milliseconds: 100));
    // Simulate loading an image successfully
    // Simulate an error response
    throw Exception("Image loading error");
  }
}
