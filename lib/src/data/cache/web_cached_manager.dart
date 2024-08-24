import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_craft/image_craft.dart';
import 'package:universal_html/html.dart';

/// A web-specific implementation of the `CacheManager<String>` class.
///
/// The `WebCacheManager` provides functionality to cache images and other
/// assets locally in web environments using local storage.
class WebCachedManager extends CachedManager<String> {
  /// Constructs an instance of the [WebCachedManager] class.
  WebCachedManager({
    Duration cacheCleanupThreshold = const Duration(days: 7),
  }) : super(cacheCleanupThreshold: cacheCleanupThreshold);

  @override
  Future<String> getLocalFile(String url) async {
    String? cachedUrl = await getCachedImage(url);
    if (cachedUrl != null) {
      return cachedUrl;
    }
    return Future.value(url);
  }

  /// Caches an image URL for web scenarios.
  Future<void> cacheImage(String url) async {
    window.localStorage[url] = url;
  }

  /// Retrieves a cached image URL for web scenarios from local storage.
  Future<String?> getCachedImage(String url) async {
    return window.localStorage[url];
  }

  /// Pre-caches an asset from the application's bundle into the
  /// local storage as a base64-encoded string.
  ///
  /// **Parameters**:
  /// - [assetPath]: A [String] representing the path of the asset.
  ///
  /// **Returns**: A [Future<void>] indicating the completion of the pre-caching operation.
  @override
  Future<void> preCacheAsset(String assetPath) async {
    // Load the asset as bytes
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    // Convert the bytes to a base64 string
    final String base64Data = base64Encode(bytes);

    // Store the base64 string in localStorage
    window.localStorage[assetPath] = base64Data;
  }

  /// Retrieves a pre-cached asset from local storage.
  ///
  /// **Parameters**:
  /// - [assetPath]: A [String] representing the path of the asset.
  ///
  /// **Returns**: A [String?] containing the base64 data or `null` if not found.
  Future<String?> getPreCachedAsset(String assetPath) async {
    return window.localStorage[assetPath];
  }
}
