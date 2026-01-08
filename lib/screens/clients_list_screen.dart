import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riveplayer/utils/rive_assets.dart';

class ClientsListScreen extends StatelessWidget {
  const ClientsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = RiveAssets.clients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Clients'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: clients.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No clients found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final clientName = clients[index];
                final filesCount = RiveAssets.getClientFiles(clientName).length;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.folder, size: 40),
                    title: Text(
                      clientName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '$filesCount Rive ${filesCount == 1 ? 'file' : 'files'}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to client's files screen
                      context.go('/client/${Uri.encodeComponent(clientName)}');
                    },
                  ),
                );
              },
            ),
    );
  }
}
