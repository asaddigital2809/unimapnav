import 'package:flutter/material.dart';
import 'package:unimapnav/widgets/custom_password_textfield.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordState();
}

class _PasswordState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _infoText = '';
  Color _infoColor = Colors.green;
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    if (_passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _infoText = 'You are good to go';
        _infoColor = Colors.green;
        _isButtonEnabled = true;
      });
    } else if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _infoText = 'Password mismatched';
        _infoColor = Colors.red;
        _isButtonEnabled = false;
      });
    } else {
      setState(() {
        _infoText = '';
        _isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomPasswordTextField(
                controller: _passwordController,
                hintText: 'Password',
                onChanged: (value) {
                  _validatePasswords();
                },
              ),
              const SizedBox(height: 20),
              CustomPasswordTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                onChanged: (value) {
                  _validatePasswords();
                },
              ),
              const SizedBox(height: 20),
              Text(
                _infoText,
                style: TextStyle(color: _infoColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        // Handle the sign-up logic here
                      }
                    : null,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
