import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riveplayer/utils/rive_assets.dart';
import 'package:riveplayer/utils/session_manager.dart';

class PasswordScreen extends StatefulWidget {
  final String clientName;
  final String redirectPath;

  const PasswordScreen({
    super.key,
    required this.clientName,
    required this.redirectPath,
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    // Check if already authenticated and redirect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (SessionManager.instance.isAuthenticated(widget.clientName)) {
        context.go(widget.redirectPath);
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPassword() {
    final password = _passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a password';
      });
      return;
    }

    if (RiveAssets.checkClientPassword(widget.clientName, password)) {
      // Authenticate the client
      SessionManager.instance.authenticate(widget.clientName);
      // Replace current route in history with the redirect path
      context.go(widget.redirectPath);
    } else {
      setState(() {
        _errorMessage = 'Invalid password';
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final decodedClientName = Uri.decodeComponent(widget.clientName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Access $decodedClientName'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 64,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Password Required',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter password for $decodedClientName',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      errorText: _errorMessage,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
                    onSubmitted: (_) => _checkPassword(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _checkPassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Enter'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
