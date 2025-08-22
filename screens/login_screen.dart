import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  String _role = 'donor';
  String _bloodGroup = 'A+';
  bool _isRegister = false;
  bool _loading = false;

  void _submit() async {
    setState(() => _loading = true);
    final auth = Provider.of<AuthService>(context, listen: false);
    try {
      if (_isRegister) {
        await auth.signUpWithEmail(_name.text, _email.text, _password.text, _role, _bloodGroup);
      } else {
        await auth.signInWithEmail(_email.text, _password.text);
      }
      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erythra Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(children: [
            if (_isRegister)
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full name')),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 8),
            Row(children: [
              const Text('Role:'),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _role,
                items: ['donor', 'recipient', 'hospital'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (v) => setState(() => _role = v!),
              ),
              const SizedBox(width: 12),
              if (_role == 'donor') DropdownButton<String>(
                value: _bloodGroup,
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (v) => setState(() => _bloodGroup = v!),
              ),
            ]),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : Text(_isRegister ? 'Register' : 'Sign In'),
            ),
            TextButton(
              onPressed: () => setState(() => _isRegister = !_isRegister),
              child: Text(_isRegister ? 'Have an account? Sign in' : 'Create an account'),
            ),
          ]),
        ),
      ),
    );
  }
}
