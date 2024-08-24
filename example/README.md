# Image Craft Example

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
