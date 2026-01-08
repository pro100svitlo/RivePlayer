/// Centralized configuration for Rive assets
class RiveAssets {
  RiveAssets._();

  /// Base path for Rive assets
  static const String basePath = 'assets/rive';

  /// List of available Rive files
  static const List<String> availableFiles = ['test.riv'];

  /// Get full asset path for a Rive file
  static String getAssetPath(String fileName) {
    return '$basePath/$fileName';
  }

  /// Check if a file exists in the available files list
  static bool isValidFile(String fileName) {
    return availableFiles.contains(fileName);
  }
}
