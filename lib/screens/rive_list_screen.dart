import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riveplayer/utils/rive_assets.dart';

class RiveListScreen extends StatelessWidget {
  const RiveListScreen({super.key});

  // List of Rive files available in assets
  static const List<String> riveFiles = [
    'test.riv',
    'test_another.riv',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Files'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: RiveAssets.availableFiles.length,
        itemBuilder: (context, index) {
          final fileName = RiveAssets.availableFiles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline, size: 40),
              title: Text(
                fileName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text('Rive animation file ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to player screen with the file name
                context.go('/player/${Uri.encodeComponent(fileName)}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add .riv files to assets/rive/ folder'),
            ),
          );
        },
        tooltip: 'Info',
        child: const Icon(Icons.info_outline),
      ),
    );
  }
}
