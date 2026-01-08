import 'dart:io';

/// Script to update the availableFiles list in rive_assets.dart
/// based on actual .riv files in assets/rive folder
void main() async {
  const assetsDir = 'assets/rive';
  const assetsFile = 'lib/utils/rive_assets.dart';

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

  // Find all .riv files
  print('Scanning for .riv files in $assetsDir...');
  final rivFiles = <String>[];

  await for (final entity in assetsDirEntity.list()) {
    if (entity is File && entity.path.endsWith('.riv')) {
      final fileName = entity.path.split('/').last;
      rivFiles.add(fileName);
    }
  }

  // Sort the files alphabetically
  rivFiles.sort();

  // Build the new availableFiles declaration
  final buffer = StringBuffer();
  buffer.writeln('  static const List<String> availableFiles = [');

  if (rivFiles.isEmpty) {
    buffer.writeln('    // No .riv files found in assets/rive');
  } else {
    for (final file in rivFiles) {
      buffer.writeln("    '$file',");
    }
  }

  buffer.write('  ];');

  // Read the current file content
  final content = await assetsFileEntity.readAsString();

  // Replace the availableFiles declaration using RegExp
  final pattern = RegExp(
    r'  static const List<String> availableFiles = \[[\s\S]*?\];',
    multiLine: true,
  );

  final newContent = content.replaceFirst(pattern, buffer.toString());

  // Write the updated content back to the file
  await assetsFileEntity.writeAsString(newContent);

  print('✅ Successfully updated $assetsFile');
  print('Found ${rivFiles.length} file(s):');
  for (final file in rivFiles) {
    print('  - $file');
  }
}
