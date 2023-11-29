import 'package:flutter/material.dart';
import 'package:unimapnav/views/aauth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      } );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [
            FlutterLogo(
              size: 200,),
            SizedBox( height: 20,),
            CircularProgressIndicator(),
            SizedBox( height: 20,),
          ],
        ),
      ),
    );
  }
}
