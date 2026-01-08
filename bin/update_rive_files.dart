import 'dart:io';

/// Script to update the riveFiles list in rive_list_screen.dart
/// based on actual .riv files in assets/rive folder
void main() async {
  const assetsDir = 'assets/rive';
  const screenFile = 'lib/screens/rive_list_screen.dart';

  // Check if assets directory exists
  final assetsDirEntity = Directory(assetsDir);
  if (!await assetsDirEntity.exists()) {
    print('Error: Directory $assetsDir does not exist');
    exit(1);
  }

  // Check if screen file exists
  final screenFileEntity = File(screenFile);
  if (!await screenFileEntity.exists()) {
    print('Error: File $screenFile does not exist');
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

  // Build the new riveFiles declaration
  final buffer = StringBuffer();
  buffer.writeln('  static const List<String> riveFiles = [');
  
  if (rivFiles.isEmpty) {
    buffer.writeln('    // No .riv files found in assets/rive');
  } else {
    for (final file in rivFiles) {
      buffer.writeln("    '$file',");
    }
  }
  
  buffer.write('  ];');

  // Read the current file content
  final content = await screenFileEntity.readAsString();

  // Replace the riveFiles declaration using RegExp
  final pattern = RegExp(
    r'  static const List<String> riveFiles = \[[\s\S]*?\];',
    multiLine: true,
  );

  final newContent = content.replaceFirst(pattern, buffer.toString());

  // Write the updated content back to the file
  await screenFileEntity.writeAsString(newContent);

  print('✅ Successfully updated $screenFile');
  print('Found ${rivFiles.length} file(s):');
  for (final file in rivFiles) {
    print('  - $file');
  }
}
