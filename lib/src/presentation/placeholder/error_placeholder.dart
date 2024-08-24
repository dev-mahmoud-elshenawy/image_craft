import 'package:flutter/material.dart';

/// A [StatelessWidget] that displays an error icon as a placeholder.
///
/// The [ErrorPlaceholder] widget is used to indicate that an error has
/// occurred while loading an image. It presents a simple visual cue
/// to the user, allowing them to understand that something went wrong.
///
/// This widget can be used in various scenarios, such as when an image
/// fails to load due to network issues, file not found, or any other
/// error conditions. The appearance of this widget can be customized
/// further by wrapping it in other widgets if needed.
///
/// **Example Usage**:
///
/// ```dart
/// ErrorPlaceholder();
/// ```
class ErrorPlaceholder extends StatelessWidget {
  /// Creates an instance of [ErrorPlaceholder].
  ///
  /// **Parameters**:
  /// - [key]: An optional [Key] that can be used to uniquely identify
  ///   the widget in the widget tree.
  const ErrorPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error, // Displays an error icon
        color: Colors.red, // Sets the color of the icon to red
      ),
    );
  }
}
