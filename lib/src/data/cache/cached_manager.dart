import 'package:flutter/foundation.dart';
import 'package:image_craft/image_craft.dart';

/// An abstract class responsible for managing cached files in the application.
///
/// The `CacheManager<T>` provides the contract for caching images and other
/// assets locally to enhance performance and reduce redundant network
/// requests. It defines methods for retrieving local files, cache cleanup,
/// and pre-caching assets.
///
/// Subclasses should implement platform-specific caching mechanisms.
///
/// ## Properties:
///
/// - `cacheCleanupThreshold` (Duration):
///   - The duration after which cached files are considered stale and
///     eligible for deletion. Default is set to 7 days.
///
/// ## Methods:
///
/// - `CacheManager({Duration cacheCleanupThreshold})`:
///   - Constructs an instance of the `CacheManager` class with an
///     optional cache cleanup threshold.
///
/// - `Future<T> getLocalFile(String url)`:
///   - Retrieves a local file corresponding to the specified URL.
///
/// - `Future<void> preCacheAsset(String assetPath)`:
///   - Pre-caches an asset from the application's bundle into the
///     temporary directory.
abstract class CachedManager<M> {
  /// The duration after which cached files are considered stale and
  /// eligible for deletion.
  final Duration cacheCleanupThreshold;

  /// Constructs an instance of the [CachedManager] class with an
  /// optional [cacheCleanupThreshold].
  ///
  /// The default value for [cacheCleanupThreshold] is set to 7 days.
  CachedManager({
    this.cacheCleanupThreshold = const Duration(days: 7),
  });

  /// Retrieves a local file corresponding to the specified [url].
  ///
  /// **Parameters**:
  /// - [url]: A [String] representing the URL of the file to cache.
  ///
  /// **Returns**: A [Future<T>] that resolves to the local file
  /// associated with the specified URL.
  Future<M> getLocalFile(String url);

  /// Static method to get the appropriate CacheManager instance based on the platform.
  static CachedManager getInstance({Duration? cacheCleanupThreshold}) {
    if (kIsWeb) {
      return WebCachedManager(
          cacheCleanupThreshold:
              cacheCleanupThreshold ?? const Duration(days: 7));
    } else {
      return UniversalCachedManager(
          cacheCleanupThreshold:
              cacheCleanupThreshold ?? const Duration(days: 7));
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
  Future<void> preCacheAsset(String assetPath);
}
