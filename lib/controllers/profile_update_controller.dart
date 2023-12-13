import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../util/app_constants.dart';

class ProfileUpdateController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool enable = false.obs;
  Future<void> uploadImageAndUpdateUser(String userId) async {

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    isLoading.value = true;
    File file = File(image.path);
    try {
      String filePath = 'profile/${image.name}';
      TaskSnapshot uploadTask = await FirebaseStorage.instance.ref(filePath).putFile(file);
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'image': imageUrl,
      });
      _getUser();
      isLoading.value = false;

     Get.snackbar('Success', 'Profile image updated successfully');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Profile image update failed');
    }
  }
  Future<void> _getUser() async {
    FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!.uid))
        .get()
        .then((value) {
      AppConstanst.userData = value.data()!;
    });
  }

  updateProfile(String name, String roll) async{
    try{
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'name': name,
        'rollNo' : roll,
      });
      enable.value = false;
      await _getUser();
      return true;
    }catch(e){
      return false;
    }

  }

}