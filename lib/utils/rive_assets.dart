/// Centralized configuration for Rive assets
class RiveAssets {
  RiveAssets._();

  /// Base path for Rive assets
  static const String basePath = 'assets/rive';

  /// Map of client name to list of their Rive files
  static const Map<String, List<String>> _clientFiles = {
    'client_name_0': [
      'test.riv',
      'test_another.riv',
    ],
    'client_name_1': [
      'test.riv',
    ],
  };

  /// Map of client name to their unique password
  static const Map<String, String> _clientPasswords = {
    'client_name_0': 'VauE_y#4JFs>S3TCd]Yb)',
    'client_name_1': 'f[}?n_9AsnK=#C:%H<oJs@IYx0dhHc',
  };

  /// Get list of all available clients
  static List<String> get clients => _clientFiles.keys.toList();

  /// Get list of Rive files for a specific client
  static List<String> getClientFiles(String clientName) {
    return _clientFiles[clientName] ?? [];
  }

  /// Check if the provided password matches the client's password
  static bool checkClientPassword(String clientName, String password) {
    return _clientPasswords[clientName] == password;
  }

  /// Get full asset path for a client's Rive file
  static String getAssetPath(String clientName, String fileName) {
    return '$basePath/$clientName/$fileName';
  }

  /// Check if a file exists for a specific client
  static bool isValidFile(String clientName, String fileName) {
    return _clientFiles[clientName]?.contains(fileName) ?? false;
  }
}
