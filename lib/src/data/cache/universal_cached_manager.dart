import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_craft/image_craft.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// A universal implementation of the `CacheManager<File>` class for non-web platforms.
///
/// The `UniversalCacheManager` provides functionality to cache images and other
/// assets locally in mobile and desktop environments using the file system.
///
/// ## Methods:
///
/// - `UniversalCacheManager({Duration cacheCleanupThreshold})`:
///   - Constructs an instance of the `UniversalCacheManager` class.
///
/// - `Future<File> getLocalFile(String url)`:
///   - Retrieves a local file corresponding to the specified URL in a non-web scenario.
///
/// - `Future<void> preCacheAsset(String assetPath)`:
///   - Pre-caches an asset from the application's bundle into the temporary directory.
class UniversalCachedManager extends CachedManager<File> {
  /// Constructs an instance of the [UniversalCachedManager] class.
  UniversalCachedManager({
    Duration cacheCleanupThreshold = const Duration(days: 7),
  }) : super(cacheCleanupThreshold: cacheCleanupThreshold);

  /// Retrieves a local file corresponding to the specified [url] in a non-web scenario.
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the file to cache.
  ///
  /// **Returns**: A [Future<File>] that resolves to the local file
  /// associated with the specified URL.
  @override
  Future<File> getLocalFile(String url) async {
    final directory = await getTemporaryDirectory();
    final filename = path.basename(Uri.parse(url).path);
    final file = File('${directory.path}/$filename');
    await _cleanupCache(directory);
    return file;
  }

  /// Cleans up old cached files in the specified [cacheDir].
  ///
  /// **Parameters**:
  /// - [cacheDir]: A [Directory] object representing the cache directory
  ///   to clean up.
  ///
  /// **Returns**: A [Future<void>], indicating the completion of the
  /// cleanup operation.
  Future<void> _cleanupCache(Directory cacheDir) async {
    final now = DateTime.now();
    final files = cacheDir.listSync();
    for (var file in files) {
      final stat = await FileStat.stat(file.path);
      if (now.difference(stat.modified) > cacheCleanupThreshold) {
        await file.delete();
      }
    }
  }

  /// Pre-caches an asset from the application's bundle into the
  /// temporary directory.
  ///
  /// **Parameters**:
  /// - [assetPath]: A [String] representing the path of the asset
  ///   within the application's bundle.
  ///
  /// **Returns**: A [Future<void>], indicating the completion of
  /// the pre-caching operation.
  @override
  Future<void> preCacheAsset(String assetPath) async {
    final directory = await getTemporaryDirectory();
    final filename = path.basename(assetPath);
    final file = File('${directory.path}/$filename');
    final ByteData data = await rootBundle.load(assetPath);
    await file.writeAsBytes(data.buffer.asUint8List());
  }
}
