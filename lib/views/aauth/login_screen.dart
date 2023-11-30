import 'package:flutter/material.dart';
import 'package:unimapnav/views/aauth/signup_screen.dart';
import 'package:unimapnav/widgets/custom_password_textfield.dart';
import 'package:unimapnav/widgets/custom_textfield.dart';

import '../bottom_nav/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          CustomTextField(
            labelText: 'Email',
            textInputType: TextInputType.emailAddress,
            borderColor: Colors.green,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordTextField(
            hintText: 'Password',

          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                  (route) => false);
            },
            child: const Text('Login'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                    (route) => false);
              },
              child: const Text(
                'I Do not have an account',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ))
        ],
      ),
    )));
  }
}
