import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimapnav/util/app_constants.dart';
import 'package:unimapnav/views/aauth/login_screen.dart';

import '../views/bottom_nav/bottom_nav.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _currentUser;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString name = ''.obs;
  RxString rollNo = ''.obs;
  UserCredential? userCredential;
  final Rxn<User> firebaseUser = Rxn<User>();

  String? get uid => _currentUser!.uid;
  Future<bool> signUp() async {



    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      // User is signed up successfully, save user data to Firestore.
      await saveUserData(userCredential!.user!);
      await _getUser();
     return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Sign up failed, please try again later.');
      return false;
    }
  }

  Future<void> saveUserData(User user) async {
    _currentUser = user;
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await userRef.set({
      'email': user.email,
      'name' : name.value,
      'rollNo': rollNo.value,
      'createdAt': FieldValue.serverTimestamp(),
      'id': user.uid,
    });
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
      });

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  Future<void> signInWithEmail(String email, String password,context) async {
    try {
      // Sign in with email and password
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value = userCredential!.user;
      await _getUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()),);
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }
  Future<void> resetPassword(String email) async {
    try {

      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.to(()=>const LoginScreen());
      Get.snackbar('Success', 'An email has been sent to $email with instructions on how to reset your password.');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
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


}