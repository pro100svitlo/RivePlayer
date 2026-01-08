import 'dart:io';

/// Script to update the clientFiles map in rive_assets.dart
/// and assets section in pubspec.yaml based on actual .riv files
/// organized by client folders in assets/rive
void main() async {
  const assetsDir = 'assets/rive';
  const assetsFile = 'lib/utils/rive_assets.dart';
  const pubspecFile = 'pubspec.yaml';

  // Check if assets directory exists
  final assetsDirEntity = Directory(assetsDir);
  if (!await assetsDirEntity.exists()) {
    print('Error: Directory $assetsDir does not exist');
    exit(1);
  }

  // Check if assets file exists
  final assetsFileEntity = File(assetsFile);
  if (!await assetsFileEntity.exists()) {
    print('Error: File $assetsFile does not exist');
    exit(1);
  }

  // Check if pubspec file exists
  final pubspecFileEntity = File(pubspecFile);
  if (!await pubspecFileEntity.exists()) {
    print('Error: File $pubspecFile does not exist');
    exit(1);
  }

  print('Scanning for client folders and .riv files in $assetsDir...');

  // Map to store client name -> list of rive files
  final Map<String, List<String>> clientFiles = {};

  // Scan for client directories
  await for (final entity in assetsDirEntity.list()) {
    if (entity is Directory) {
      final clientName = entity.path.split('/').last;
      final rivFiles = <String>[];

      // Find all .riv files in this client's directory
      await for (final file in entity.list()) {
        if (file is File && file.path.endsWith('.riv')) {
          final fileName = file.path.split('/').last;
          rivFiles.add(fileName);
        }
      }

      // Sort the files alphabetically
      rivFiles.sort();

      if (rivFiles.isNotEmpty) {
        clientFiles[clientName] = rivFiles;
      }
    }
  }

  // Sort clients alphabetically
  final sortedClients = clientFiles.keys.toList()..sort();

  // Build the new clientFiles map declaration
  final buffer = StringBuffer();
  buffer.writeln('  static const Map<String, List<String>> clientFiles = {');

  if (sortedClients.isEmpty) {
    buffer.writeln(
      '    // No client folders with .riv files found in assets/rive',
    );
  } else {
    for (final client in sortedClients) {
      final files = clientFiles[client]!;
      buffer.writeln("    '$client': [");
      for (final file in files) {
        buffer.writeln("      '$file',");
      }
      buffer.writeln('    ],');
    }
  }

  buffer.write('  };');

  // Read the current file content
  final content = await assetsFileEntity.readAsString();

  // Replace the clientFiles declaration using RegExp
  final pattern = RegExp(
    r'  static const Map<String, List<String>> clientFiles = \{[\s\S]*?\};',
    multiLine: true,
  );

  final newContent = content.replaceFirst(pattern, buffer.toString());

  // Write the updated content back to the file
  await assetsFileEntity.writeAsString(newContent);

  print('✅ Successfully updated $assetsFile');

  // Update pubspec.yaml assets section
  final pubspecContent = await pubspecFileEntity.readAsString();

  // Build the new assets declaration
  final assetsBuffer = StringBuffer();
  assetsBuffer.writeln('  assets:');

  if (sortedClients.isEmpty) {
    assetsBuffer.writeln('    # No client folders found in assets/rive');
  } else {
    for (final client in sortedClients) {
      assetsBuffer.writeln('    - assets/rive/$client/');
    }
  }

  // Replace the assets declaration using RegExp
  final assetsPattern = RegExp(
    r'  assets:\s*\n(?:    - .*\n)*',
    multiLine: true,
  );

  final newPubspecContent = pubspecContent.replaceFirst(
    assetsPattern,
    assetsBuffer.toString(),
  );

  // Write the updated content back to pubspec.yaml
  await pubspecFileEntity.writeAsString(newPubspecContent);

  print('✅ Successfully updated $pubspecFile');
  print('Found ${sortedClients.length} client(s):');
  for (final client in sortedClients) {
    final files = clientFiles[client]!;
    print('  $client: ${files.length} file(s)');
    for (final file in files) {
      print('    - $file');
    }
  }
}
