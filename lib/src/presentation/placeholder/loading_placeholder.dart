import 'package:flutter/material.dart';

/// A [StatelessWidget] that displays a loading indicator.
///
/// The [LoadingPlaceholder] widget serves as a visual cue to inform users
/// that content is currently being loaded. It features a circular progress
/// indicator, which is a common UI pattern in Flutter applications.
///
/// This widget is particularly useful when fetching images, data, or any
/// other asynchronous operation, indicating to the user that they should
/// wait for the content to load.
///
/// **Example Usage**:
///
/// ```dart
/// LoadingPlaceholder();
/// ```
class LoadingPlaceholder extends StatelessWidget {
  /// Creates an instance of [LoadingPlaceholder].
  ///
  /// **Parameters**:
  /// - [key]: An optional [Key] that can be used to uniquely identify
  ///   the widget in the widget tree.
  const LoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          CircularProgressIndicator(), // Displays a circular progress indicator
    );
  }
}
