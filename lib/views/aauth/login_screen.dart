import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimapnav/views/aauth/signup_screen.dart';
import 'package:unimapnav/widgets/custom_password_textfield.dart';
import 'package:unimapnav/widgets/custom_textfield.dart';

import '../../controllers/user_controller.dart';
import '../bottom_nav/bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserController _userController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    try {
      _userController = Get.find();
    } catch (e) {
      _userController = Get.put(UserController());
    }
    super.initState();
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
          CustomTextField(
            labelText: 'Email',
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            borderColor: Colors.green,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordTextField(
            hintText: 'Password',
            controller: passwordController,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()async {
                if(emailController.text.isEmpty || passwordController.text.isEmpty){
                  Get.snackbar('Error', 'Please fill all the fields');
                  return;
                }

                 await  _userController.signInWithEmail(
                    emailController.text, passwordController.text,context);


              },
              child: const Text('Login'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(
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
