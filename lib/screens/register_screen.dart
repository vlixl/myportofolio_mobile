import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

/// Creates a new account, then logs the user in with the returned token.
///
/// Pops with `true` when registration succeeds.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _passwordConfirmation = '';
  bool _isSubmitting = false;

  /// Errors returned by Django, keyed by field (username, password1, password2).
  Map<String, String> _serverErrors = {};

  Future<void> _submit() async {
    setState(() {
      _serverErrors = {};
    });
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    final auth = context.read<AuthState>();
    final messenger = ScaffoldMessenger.of(context);

    try {
      await auth.register(_username, _password, _passwordConfirmation);
      messenger.showSnackBar(
        SnackBar(content: Text('Welcome, $_username! Your account is ready.')),
      );
      if (mounted) {
        Navigator.pop(context, true);
      }
    } on ApiException catch (e) {
      final errors = _parseErrors(e);
      if (errors.isEmpty) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        setState(() {
          _serverErrors = errors;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// Turns Django's `{"field": ["message", ...]}` body into one message per field.
  Map<String, String> _parseErrors(ApiException e) {
    if (e.statusCode != 400) return {};
    try {
      final decoded = jsonDecode(e.message) as Map<String, dynamic>;
      return decoded.map(
        (field, messages) => MapEntry(
          field,
          (messages as List<dynamic>).map((m) => m.toString()).join('\n'),
        ),
      );
    } on FormatException {
      return {};
    } on TypeError {
      return {};
    }
  }

  InputDecoration _decoration(String label, String field) {
    return InputDecoration(
      hintText: label,
      labelText: label,
      errorText: _serverErrors[field],
      errorMaxLines: 5,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: _decoration('Username', 'username'),
                onChanged: (value) => _username = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Username cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: _decoration('Password', 'password1'),
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: _decoration('Confirm password', 'password2'),
                onChanged: (value) => _passwordConfirmation = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password!';
                  }
                  if (value != _password) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },
              ),
              if (_serverErrors['__all__'] != null) ...[
                const SizedBox(height: 16),
                Text(
                  _serverErrors['__all__']!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Register'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
