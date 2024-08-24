# ImageCraft

A ImageCraft package for efficiently loading and caching images from various sources, including
network URLs, assets, SVG files, and local files. `ImageCraft` aims to simplify image handling in
Flutter applications while providing robust caching mechanisms.

[![Pub Package](https://img.shields.io/badge/Pub%20get-Image%20Craft-yellow)](https://pub.dev/packages/image_craft)
![Build Status](https://img.shields.io/badge/Build-Passing-teal)
![Unit Test](https://img.shields.io/badge/Unit%20Test-Passing-red)
[![creator](https://img.shields.io/badge/Creator-Mahmoud%20El%20Shenawy-blue)](https://www.linkedin.com/in/dev-mahmoud-elshenawy)
<a href="https://www.buymeacoffee.com/m.elshenawy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="30" width="174" > </a>

## Importance

The `image_craft` package simplifies the image loading and caching process in Flutter applications.
By providing a unified interface for handling various image sources, it allows developers to
efficiently manage images without dealing with complex caching logic or error handling. This package
saves valuable development time and enhances app performance, ensuring that images load quickly and
reliably, while also providing a smooth user experience with customizable placeholders and error
widgets.

## Features

- Load images from network URLs with automatic caching.
- Load images from the asset bundle.
- Support for SVG images using the `flutter_svg` package.
- Easy integration with customizable loading and error widgets.
- Pre-caching of assets for improved performance.

## Necessary Permissions

To ensure the smooth functioning of the **image_craft** package across all platforms, you need to
add the following permissions based on the features you intend to use:

### Mobile (iOS and Android)

- **Android**:
    - Add the following permissions to your `AndroidManifest.xml`:
      ```xml
      <uses-permission android:name="android.permission.INTERNET"/>
      <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
      <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
      ```

- **iOS**:
    - Update your `Info.plist` with the following keys:
      ```xml
      <key>NSPhotoLibraryUsageDescription</key>
      <string>This app requires access to the photo library for image loading.</string>
      <key>NSPhotoLibraryAddUsageDescription</key>
      <string>This app requires permission to save images to your photo library.</string>
      <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
        </dict>
      ```

### Desktop (Linux, Windows, macOS)

- **Linux**:
    - Ensure that your application has permissions to access files, especially if you're loading
      images from the file system.

- **Windows**:
    - If your application needs to access the file system, ensure the necessary permissions are set
      in your application manifest.

- **macOS**:
    - Add the following keys to your `Info.plist` for accessing files:
        ```xml
      <key>NSPhotoLibraryUsageDescription</key>
      <string>This app requires access to the photo library for image loading.</string>
      <key>NSPhotoLibraryAddUsageDescription</key>
      <string>This app requires permission to save images to your photo library.</string>
      <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
        </dict>
      ```
      
### Web

- No additional permissions are typically required for web applications, but make sure your server
  configuration allows for CORS if you're fetching images from external sources.

By ensuring that these permissions are set, you can utilize all features of the **image_craft**
package, including caching network images, without running into bugs or issues.

## Usage

Here's a simple example of how to use the `image_craft` package for each image type:

### 1. **Network Image**

```dart
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class NetworkImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network Image Example')),
      body: Center(
        child: ImageCraft(
          path: 'https://example.com/image.png',
          imageType: ImageType.NETWORK,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          placeholder: LoadingPlaceholder(),
          errorWidget: ErrorPlaceholder(),
        ),
      ),
    );
  }
}
```

### 2. **Asset Image**

```dart
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class AssetImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset Image Example')),
      body: Center(
        child: ImageCraft(
          path: 'assets/images/my_image.png',
          imageType: ImageType.ASSET,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          placeholder: LoadingPlaceholder(),
          errorWidget: ErrorPlaceholder(),
        ),
      ),
    );
  }
}
```

### 3. **SVG Image**

```dart
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class SvgImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SVG Image Example')),
      body: Center(
        child: ImageCraft(
          path: 'assets/images/my_image.svg',
          imageType: ImageType.SVG,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          placeholder: LoadingPlaceholder(),
          errorWidget: ErrorPlaceholder(),
        ),
      ),
    );
  }
}
```

### 4. **File Image**

```dart
import 'package:flutter/material.dart';
import 'package:image_craft/image_craft.dart';

class FileImageExample extends StatelessWidget {
  final File imageFile;

  FileImageExample({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Image Example')),
      body: Center(
        child: ImageCraft(
          path: imageFile.path,
          imageType: ImageType.FILE,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          placeholder: LoadingPlaceholder(),
          errorWidget: ErrorPlaceholder(),
        ),
      ),
    );
  }
}
```

Feel free to modify any part to better fit your package or to add any additional details you find relevant!

## Customization and Global Overrides

The `image_craft` package is designed with flexibility in mind, allowing you to customize and override various components globally. This enables you to tailor the image loading experience to suit your application's specific needs. Below are the key components that can be modified or overridden:

### 1. **Image Loader Factory**

The `ImageLoaderFactory` class allows you to set a custom image loader for all image types. You can override the default loader by using the `setLoaderOverride` method:

```dart
ImageLoaderFactory.setLoaderOverride((imageType) {
  // Return your custom ImageLoader instance based on the image type
  return MyCustomImageLoader();
});
```

### 2. **Error and Loading Placeholders**

You can customize the widgets used for displaying errors or loading indicators globally. By extending the existing LoadingPlaceholder and ErrorPlaceholder classes, you can create your own versions and specify them when creating an instance of ImageCraft. Here’s how you can set custom placeholders:

- **Custom Loading Placeholder**:

```dart
import 'package:flutter/material.dart';

/// A custom loading placeholder that extends the [LoadingPlaceholder].
class CustomLoadingPlaceholder extends LoadingPlaceholder {
  const CustomLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 10),
          Text(
            'Loading, please wait...',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
```

- **Custom Error Placeholder**:

```dart
import 'package:flutter/material.dart';

/// A custom error placeholder that extends the [ErrorPlaceholder].
class CustomErrorPlaceholder extends ErrorPlaceholder {
  const CustomErrorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            'Oops! Something went wrong.',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
```
- **Setting Custom Placeholders**:

```dart
void main() {
 // Setting a custom loading placeholder
  PlaceholderManager.setLoadingPlaceholderBuilder(() => CustomLoadingPlaceholder());
 
  // Setting a custom error placeholder
  PlaceholderManager.setErrorPlaceholderBuilder(() => CustomErrorPlaceholder());
  
   runApp(MaterialApp(
     home: Scaffold(
       body: Center(
         child: PlaceholderManager.getLoadingPlaceholder(),
       ),
     ),
   ));
 }
```

### 3. **CacheManager Configuration**

You can create a custom instance of CacheManager to modify cache settings such as the cleanup threshold. Pass your custom CacheManager instance when creating an image loader:

```dart
final myCacheManager = CacheManager(cacheCleanupThreshold: Duration(days: 14));
final imageLoader = NetworkImageLoader(cacheManager: myCacheManager);
```

### 4. **Image Decoder Customization**

If you need to customize how images are decoded, you can create a subclass of ImageDecoder and override the decodeImage method. Then, use your custom decoder in the relevant image loaders:

```dart
class MyCustomImageDecoder extends ImageDecoder {
  @override
  Future<ui.Image> decodeImage(File file) async {
    // Custom decoding logic
  }
}
```

By modifying these components, you can achieve a global configuration for your image loading strategy in the image_craft package, ensuring consistency and flexibility across your Flutter application.

## Note

- **Caching Behavior**: The `image_craft` package includes caching mechanisms for network images, ensuring that images are stored locally for quicker access. Be mindful of the cache size and cleanup strategies to manage storage effectively.
- **Performance Considerations**: When using SVG images, consider the complexity of the SVGs, as intricate designs may affect rendering performance. Always optimize SVG files for the best results.
- **Error Handling**: Implement custom error widgets to improve user experience when loading images fails. Ensure that your application gracefully handles scenarios where images cannot be loaded.
- **Testing**: If you override any loaders or customize behaviors, ensure thorough testing across all platforms to verify that the image loading behaves as expected.
- **Permissions**: Check and set the necessary permissions for your application to access images from various sources, including network URLs, assets, and local files.
- **Customization**: Leverage the customization options provided by the `image_craft` package to tailor the image loading experience to your application's requirements.
- **Feedback**: Your feedback and suggestions are valuable for improving the package. If you encounter any issues or have ideas for enhancements, please report them on the GitHub Issues page.
- **Support**: If you find this package helpful, consider supporting the creator by buying them a coffee or providing feedback on how it has benefited your projects.
- **Contribution**: Contributions to the package are welcome. If you have ideas for enhancements or new features, feel free to submit a pull request on GitHub.

## Report Issues

If you encounter any issues, bugs, or have suggestions for improvements, please report them on the [GitHub Issues page](https://github.com/Mahmoud-ElShenawy/image_craft/issues).

When reporting an issue, please provide the following information:
- A clear description of the problem or feature request.
- Steps to reproduce the issue (if applicable).
- The version of the Auto Validate package you are using.
- Any relevant code snippets or screenshots.

Your feedback is invaluable for improving the package and helping others in the community!

## Created By

- **Mahmoud El Shenawy** - [Mahmoud-ElShenawy](https://www.linkedin.com/in/dev-mahmoud-elshenawy)

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Mahmoud-ElShenawy/image_craft/blob/master/LICENSE) file for details