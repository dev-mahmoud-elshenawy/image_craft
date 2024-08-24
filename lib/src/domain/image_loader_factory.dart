import 'package:image_craft/image_craft.dart';

/// A factory class for creating instances of [ImageLoader].
///
/// The `ImageLoaderFactory` class is responsible for providing the appropriate
/// image loader implementation based on the specified [ImageType]. It allows
/// for flexible instantiation of image loaders and supports overriding the
/// default loader behavior for testing purposes.
///
/// This factory pattern is useful for managing multiple types of image loading
/// strategies in a clean and maintainable way.
///
/// ## Methods:
///
/// - `ImageLoader getImageLoader(ImageType imageType)`:
///   - Returns an instance of [ImageLoader] based on the specified [imageType].
///   - **Parameters**:
///     - `imageType`: An [ImageType] enum value that indicates the type of
///       image loader to create (e.g., NETWORK, ASSET, SVG, FILE).
///   - **Returns**: An instance of [ImageLoader] corresponding to the
///     requested image type.
///   - **Throws**:
///     - [UnsupportedError] if the specified [imageType] is not supported.
///   - **Example**:
///     ```dart
///     ImageLoader loader = ImageLoaderFactory.getImageLoader(ImageType.NETWORK);
///     ```
///
/// - `void setLoaderOverride(ImageLoader Function(ImageType) loader)`:
///   - Allows for overriding the default loader implementation, useful for
///     testing or custom behavior.
///   - **Parameters**:
///     - `loader`: A function that takes an [ImageType] and returns an
///       instance of [ImageLoader].
///
/// - `void resetLoaderOverride()`:
///   - Resets the loader override to the default implementation.
///
/// ## Usage:
///
/// The factory pattern allows clients to request specific image loaders
/// without needing to know the concrete classes. This abstraction makes
/// it easier to manage different loading strategies and facilitates
/// unit testing by allowing developers to inject mock loaders as needed.
class ImageLoaderFactory {
  static ImageLoader Function(ImageType)? _overrideLoader;

  /// Returns an instance of [ImageLoader] based on the specified [imageType].
  ///
  /// If an override loader has been set using [setLoaderOverride], that loader
  /// will be returned. Otherwise, the factory will return the default loader
  /// implementation based on the [imageType].
  ///
  /// **Parameters**:
  /// - [imageType]: An [ImageType] enum value indicating the type of image
  ///   loader to create.
  ///
  /// **Returns**: An instance of [ImageLoader] corresponding to the requested
  /// image type.
  ///
  /// **Throws**:
  /// - [UnsupportedError] if the specified [imageType] is not supported.
  static ImageLoader getImageLoader(ImageType imageType) {
    if (_overrideLoader != null) {
      return _overrideLoader!(imageType);
    }

    switch (imageType) {
      case ImageType.NETWORK:
        return NetworkImageLoader();
      case ImageType.ASSET:
        return AssetImageLoader();
      case ImageType.SVG:
        return SvgImageLoader();
      case ImageType.FILE:
        return FileImageLoader();
      default:
        throw UnsupportedError('Unsupported image type');
    }
  }

  /// Sets a custom loader implementation for testing purposes.
  ///
  /// **Parameters**:
  /// - [loader]: A function that takes an [ImageType] and returns an instance
  ///   of [ImageLoader].
  static void setLoaderOverride(ImageLoader Function(ImageType) loader) {
    _overrideLoader = loader;
  }

  /// Resets the loader override to the default implementation.
  static void resetLoaderOverride() {
    _overrideLoader = null;
  }
}
