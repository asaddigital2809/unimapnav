import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimapnav/views/aauth/login_screen.dart';
import 'package:unimapnav/views/bottom_nav/bottom_nav.dart';

import '../../util/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _getUser() async {
    FirebaseAuth.instance.currentUser!.uid;
   await FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!.uid))
        .get()
        .then((value) {
      AppConstanst.userData = value.data()!;
    });
  }
  goNext(){
    Future.delayed(const Duration(seconds: 3), () async{
      if (FirebaseAuth.instance.currentUser != null) {
        await _getUser();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      }
    } );
  }
  @override
  void initState() {
    goNext();
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
