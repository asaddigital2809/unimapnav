import 'package:flutter/material.dart';
import 'package:unimapnav/widgets/custom_textfield.dart';

import '../passwords/password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _infoText = '';
  bool _isButtonEnabled = false;

  bool _isEmailValid(String email) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  void _updateButtonState() {
    final allFieldsFilled = _nameController.text.isNotEmpty &&
        _rollNumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty;

    final isEmailValid = _isEmailValid(_emailController.text);

    setState(() {
      if (!allFieldsFilled) {
        _infoText = 'Please fill all the fields';
        _isButtonEnabled = false;
      } else if (!isEmailValid) {
        _infoText = 'Please enter a valid email address';
        _isButtonEnabled = false;
      } else {
        _infoText = '';
        _isButtonEnabled = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_updateButtonState);
    _rollNumberController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_isButtonEnabled) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Password()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        _isEmailValid(_emailController.text) || _emailController.text.isEmpty
            ? Colors.grey
            : Colors.red;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            const FlutterLogo(
            size: 100,),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _nameController,
                labelText: 'Name',
                textInputType: TextInputType.text,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _rollNumberController,
                labelText: 'Roll number',
                textInputType: TextInputType.number,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                _infoText,
                style: const TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _onNextPressed : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
