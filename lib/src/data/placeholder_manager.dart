import 'package:image_craft/image_craft.dart';

/// A manager class that allows for globally overriding the loading and error
/// placeholder widgets used throughout the application.
///
/// The `PlaceholderManager` provides static methods to set custom placeholder
/// builders for loading and error states, allowing for a consistent user
/// experience across the app. By default, it uses the standard
/// `LoadingPlaceholder` and `ErrorPlaceholder` widgets, but these can be
/// replaced with custom implementations as needed.
///
/// ## Methods:
///
/// - `static void setLoadingPlaceholderBuilder(LoadingPlaceholder Function() builder)`:
///   - Sets a custom loading placeholder builder.
///   - **Parameters**:
///     - `builder`: A function that returns a new instance of a
///       [LoadingPlaceholder].
///
/// - `static LoadingPlaceholder getLoadingPlaceholder()`:
///   - Returns the currently set loading placeholder or a default one.
///   - **Returns**: A [LoadingPlaceholder] widget.
///
/// - `static void setErrorPlaceholderBuilder(ErrorPlaceholder Function() builder)`:
///   - Sets a custom error placeholder builder.
///   - **Parameters**:
///     - `builder`: A function that returns a new instance of an
///       [ErrorPlaceholder].
///
/// - `static ErrorPlaceholder getErrorPlaceholder()`:
///   - Returns the currently set error placeholder or a default one.
///   - **Returns**: An [ErrorPlaceholder] widget.
///
/// ## Usage Example:
///
/// Here is an example of how to use the `PlaceholderManager` class to set
/// custom placeholders in a Flutter application:
///
/// ```dart
/// void main() {
///   // Setting a custom loading placeholder
///   PlaceholderManager.setLoadingPlaceholderBuilder(() => CustomLoadingPlaceholder());
///
///   // Setting a custom error placeholder
///   PlaceholderManager.setErrorPlaceholderBuilder(() => CustomErrorPlaceholder());
///
///   runApp(MaterialApp(
///     home: Scaffold(
///       body: Center(
///         child: PlaceholderManager.getLoadingPlaceholder(),
///       ),
///     ),
///   ));
/// }
/// ```
///
/// ## Note:
///
/// Ensure that the custom placeholders implement the necessary design and
/// functionality to enhance user experience throughout the application.
class PlaceholderManager {
  static LoadingPlaceholder Function()? _loadingPlaceholderBuilder;
  static ErrorPlaceholder Function()? _errorPlaceholderBuilder;

  /// Sets a custom loading placeholder builder.
  static void setLoadingPlaceholderBuilder(
      LoadingPlaceholder Function() builder) {
    _loadingPlaceholderBuilder = builder;
  }

  /// Returns the currently set loading placeholder or a default one.
  static LoadingPlaceholder getLoadingPlaceholder() {
    return _loadingPlaceholderBuilder?.call() ?? LoadingPlaceholder();
  }

  /// Sets a custom error placeholder builder.
  static void setErrorPlaceholderBuilder(ErrorPlaceholder Function() builder) {
    _errorPlaceholderBuilder = builder;
  }

  /// Returns the currently set error placeholder or a default one.
  static ErrorPlaceholder getErrorPlaceholder() {
    return _errorPlaceholderBuilder?.call() ?? ErrorPlaceholder();
  }
}
