import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:html' as html; // For web caching

/// A class responsible for managing cached files in the application.
///
/// The `CacheManager` provides functionality to cache images and other
/// assets locally to enhance performance and reduce redundant network
/// requests. It handles the retrieval of local files, cache cleanup
/// based on specified thresholds, and pre-caching of assets from the
/// application bundle.
///
/// This class is particularly useful in scenarios where image loading
/// is frequent, as it can help improve loading times and reduce the
/// amount of data fetched from remote sources.
///
/// ## Properties:
///
/// - `cacheCleanupThreshold` (Duration):
///   - The duration after which cached files are considered stale and
///     eligible for deletion. Default is set to 7 days.
///   - Example:
///     ```dart
///     final cacheManager = CacheManager(cacheCleanupThreshold: Duration(days: 10));
///     ```
///
/// ## Methods:
///
/// - `CacheManager({Duration cacheCleanupThreshold})`:
///   - Constructs an instance of the `CacheManager` class with an
///     optional cache cleanup threshold.
///
/// - `Future<File> getLocalFile(String url)`:
///   - Retrieves a local file corresponding to the specified URL.
///   - If the file does not exist, it creates a new `File` instance
///     in the temporary directory. It also invokes the `_cleanupCache`
///     method to remove stale files.
///   - **Parameters**:
///     - `url`: A `String` representing the URL of the file to cache.
///   - **Returns**: A `Future<File>` that resolves to the local file
///     associated with the specified URL.
///
/// - `Future<void> _cleanupCache(Directory cacheDir)`:
///   - Cleans up old cached files in the specified cache directory.
///   - This method is not intended to be called directly. It is used
///     internally to maintain the cache by deleting files that have
///     not been modified within the defined `cacheCleanupThreshold`.
///
/// - `Future<void> preCacheAsset(String assetPath)`:
///   - Pre-caches an asset from the application's bundle into the
///     temporary directory. This is useful for assets that are
///     frequently used, allowing them to be loaded quickly without
///     fetching them from the network or reading them from disk each time.
///
/// - `Future<void> cacheImage(String url)`:
///   - Caches an image URL for web scenarios. This will store the image URL
///     in local storage.
///
/// - `Future<String?> getCachedImage(String url)`:
///   - Retrieves a cached image URL for web scenarios from local storage.
///
/// ## Usage Example:
///
/// Here is an example of how to use the `CacheManager` class to
/// manage cached files in an application:
///
/// ```dart
/// void main() async {
///   final cacheManager = CacheManager();
///   final localFile = await cacheManager.getLocalFile('https://example.com/image.png');
///   await cacheManager.preCacheAsset('assets/images/logo.png');
/// }
/// ```
///
/// ## Note:
///
/// Ensure that the app has the necessary permissions to read and write
/// files in the temporary directory, especially when running on different
/// platforms (Android, iOS, etc.).
class CacheManager {
  /// The duration after which cached files are considered stale and
  /// eligible for deletion.
  final Duration cacheCleanupThreshold;

  /// Constructs an instance of the [CacheManager] class with an
  /// optional [cacheCleanupThreshold].
  ///
  /// The default value for [cacheCleanupThreshold] is set to 7 days.
  CacheManager({
    this.cacheCleanupThreshold = const Duration(days: 7),
  });

  /// Retrieves a local file corresponding to the specified [url].
  ///
  /// If the file does not exist, it creates a new [File] instance
  /// in the temporary directory. This method also invokes the
  /// [_cleanupCache] method to remove stale files that exceed the
  /// [cacheCleanupThreshold].
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the file to cache.
  ///
  /// **Returns**: A [Future<File>] that resolves to the local file
  /// associated with the specified URL.
  Future<File> getLocalFile(String url) async {
    if (kIsWeb) {
      // Handle web caching
      return _getWebFile(url);
    } else {
      // Handle mobile caching
      final directory = await getTemporaryDirectory();
      final filename = path.basename(Uri.parse(url).path);
      final file = File('${directory.path}/$filename');
      await _cleanupCache(directory);
      return file;
    }
  }

  /// Handles retrieving a cached file URL for web scenarios.
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the file to cache.
  ///
  /// **Returns**: A [Future<File>] that resolves to the local file
  /// associated with the specified URL.
  Future<File> _getWebFile(String url) async {
    // In web, we return a placeholder or perform web caching using localStorage
    String? cachedUrl = await getCachedImage(url);
    if (cachedUrl != null) {
      // For demo purposes, we simulate file retrieval (web only)
      return File(
          cachedUrl); // In a real scenario, you may not have a File object here.
    }
    return Future.value(File(url)); // Return the URL wrapped in a File object.
  }

  /// Cleans up old cached files in the specified [cacheDir].
  ///
  /// This method is used internally to maintain the cache by deleting
  /// files that have not been modified within the defined
  /// [cacheCleanupThreshold]. It is not intended to be called directly.
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
      // Delete the file if it has not been modified within the cleanup threshold.
      if (now.difference(stat.modified) > cacheCleanupThreshold) {
        await file.delete();
      }
    }
  }

  /// Pre-caches an asset from the application's bundle into the
  /// temporary directory.
  ///
  /// This method is useful for assets that are frequently used, allowing
  /// them to be loaded quickly without fetching them from the network
  /// or reading them from disk each time.
  ///
  /// **Parameters**:
  /// - [assetPath]: A [String] representing the path of the asset
  ///   within the application's bundle.
  ///
  /// **Returns**: A [Future<void>], indicating the completion of
  /// the pre-caching operation.
  Future<void> preCacheAsset(String assetPath) async {
    if (kIsWeb) {
      // For web, assets can be handled differently
      return; // Implement web asset caching if needed
    } else {
      final directory = await getTemporaryDirectory();
      final filename = path.basename(assetPath);
      final file = File('${directory.path}/$filename');
      // Load the asset data and write it to the cache.
      final ByteData data = await rootBundle.load(assetPath);
      await file.writeAsBytes(data.buffer.asUint8List());
    }
  }

  /// Caches an image URL for web scenarios.
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the image to cache.
  ///
  /// **Returns**: A [Future<void>] indicating the completion of the caching operation.
  Future<void> cacheImage(String url) async {
    if (kIsWeb) {
      html.window.localStorage[url] =
          url; // Store the image URL in local storage
    }
  }

  /// Retrieves a cached image URL for web scenarios from local storage.
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the image to retrieve.
  ///
  /// **Returns**: A [Future<String?>] that resolves to the cached image URL or `null` if not found.
  Future<String?> getCachedImage(String url) async {
    if (kIsWeb) {
      return html.window.localStorage[url]; // Retrieve the cached image URL
    }
    return null; // Return null for non-web platforms
  }
}
