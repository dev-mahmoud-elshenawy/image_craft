/// An enumeration representing the different types of image sources
/// that can be used in the ImageCraft package.
///
/// This enum is utilized to specify the type of image being loaded
/// and informs the image loading mechanism which appropriate loader
/// to utilize based on the source type. Each enum value corresponds
/// to a specific method of retrieving and rendering images within
/// the application.
///
/// The `ImageCraft` class and related image loading classes
/// (such as `NetworkImageLoader`, `AssetImageLoader`, etc.) utilize
/// this enum to determine how to process and display images based
/// on their respective sources.
///
/// ## Enum Values:
///
/// - `NETWORK`:
///   - Represents images that are sourced from a remote server via
///     a URL. This type is used when loading images over the internet
///     and is typically handled by the `NetworkImageLoader`.
///   - Example usage:
///     ```dart
///     final imageType = ImageType.NETWORK;
///     ```
///
/// - `ASSET`:
///   - Indicates images that are bundled with the application and
///     stored in the asset directory. This type is used when loading
///     images that are included in the app's resources and is handled
///     by the `AssetImageLoader`.
///   - Example usage:
///     ```dart
///     final imageType = ImageType.ASSET;
///     ```
///
/// - `SVG`:
///   - Denotes images in Scalable Vector Graphics (SVG) format. This
///     type is utilized for vector images that can be scaled without
///     loss of quality. It is handled by the `SvgImageLoader`.
///   - Example usage:
///     ```dart
///     final imageType = ImageType.SVG;
///     ```
///
/// - `FILE`:
///   - Represents images that are loaded from the device's file
///     system. This type is used when retrieving images stored
///     locally on the device, such as user-uploaded images,
///     and is handled by the `FileImageLoader`.
///   - Example usage:
///     ```dart
///     final imageType = ImageType.FILE;
///     ```
///
/// ## Usage Example:
///
/// Here is an example of how to use the `ImageType` enum in conjunction
/// with the `ImageCraft` widget:
///
/// ```dart
/// ImageCraft(
///   path: 'https://example.com/image.png',
///   imageType: ImageType.NETWORK,
///   fit: BoxFit.cover,
///   width: 200.0,
///   height: 100.0,
///   placeholder: CircularProgressIndicator(),
///   errorWidget: Text('Failed to load image'),
/// );
/// ```
///
/// ## Note:
/// Ensure that you handle each `ImageType` appropriately in your
/// image loading logic to provide a smooth user experience across
/// various image sources.
enum ImageType {
  NETWORK,
  ASSET,
  SVG,
  FILE,
}