import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:riveplayer/utils/rive_assets.dart';

class RivePlayerScreen extends StatefulWidget {
  final String fileName;

  const RivePlayerScreen({super.key, required this.fileName});

  @override
  State<RivePlayerScreen> createState() => _RivePlayerScreenState();
}

class _RivePlayerScreenState extends State<RivePlayerScreen> {
  late final fileLoader = FileLoader.fromAsset(
    RiveAssets.getAssetPath(widget.fileName),
    riveFactory: Factory.rive,
  );

  String? _errorMessage;

  @override
  void dispose() {
    fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decodedFileName = Uri.decodeComponent(widget.fileName);

    return Scaffold(
      appBar: AppBar(
        title: Text(decodedFileName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: RiveWidgetBuilder(
        fileLoader: fileLoader,
        builder: (context, state) => switch (state) {
          RiveLoading() => const Center(child: CircularProgressIndicator()),
          RiveFailed() => _buildErrorWidget(),
          RiveLoaded() => Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: RiveWidget(
                    controller: state.controller,
                    fit: Fit.cover,
                  ),
                ),
              ),
            ),
          ),
        },
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 80),
          const SizedBox(height: 24),
          Text(
            'Failed to load Rive file',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage ??
                'The file "${widget.fileName}" could not be loaded.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const Text(
            'Make sure to place your .riv files in the assets/rive/ folder',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to List'),
          ),
        ],
      ),
    );
  }
}
