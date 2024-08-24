import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_craft/image_craft.dart';

import 'mock/mock_manager.dart';

void main() {
  testWidgets('ImageCraft loads an asset image', (WidgetTester tester) async {
    // Mock the necessary dependencies and responses here
    final String assetPath = 'assets/image.jpg';
    final ImageType imageType = ImageType.ASSET;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImageCraft(
            path: assetPath,
            imageType: imageType,
          ),
        ),
      ),
    );

    // Initially, the LoadingPlaceholder should be shown
    expect(find.byType(LoadingPlaceholder), findsOneWidget);

    // Simulate the completion of the Future and re-build the widget
    await tester.pumpAndSettle();

    // Check that the correct image widget is rendered
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ImageCraft shows error widget on error',
      (WidgetTester tester) async {
    // Use the mock image loader
    final mockImageLoader = MockCacheManager();

    // Replace the image loader in the factory with the mock
    ImageLoaderFactory.setLoaderOverride((imageType) {
      return mockImageLoader;
    });

    // Mock an invalid URL
    final String invalidPath =
        'https://w7.pngwing.com/pngs/537/866/png-transparent-flutter-hd-logo.png';
    final ImageType imageType = ImageType.NETWORK;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImageCraft(
            path: invalidPath,
            imageType: imageType,
            errorWidget: Text('Error loading image'),
          ),
        ),
      ),
    );

    // Initially, the LoadingPlaceholder should be shown
    expect(find.byType(LoadingPlaceholder), findsOneWidget);

    // Simulate the completion of the Future and re-build the widget
    await tester.pumpAndSettle();

    // Check that the error widget is shown
    expect(find.text('Error loading image'), findsOneWidget);

    // Clean up the factory
    ImageLoaderFactory.resetLoaderOverride();
  });

  testWidgets('ImageCraft shows placeholder while loading',
      (WidgetTester tester) async {
    final String assetPath = 'assets/image.png';
    final ImageType imageType = ImageType.ASSET;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImageCraft(
            path: assetPath,
            imageType: imageType,
            placeholder: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    // Check that the placeholder is displayed while the image is loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
