import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimapnav/util/app_constants.dart';
import 'package:unimapnav/widgets/custom_textfield.dart';

import '../../controllers/profile_update_controller.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ProfileUpdateController _profileUpdateController =
      Get.put(ProfileUpdateController());
  ImageProvider? _profileImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _rollController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = FileImage(File(pickedFile.path));
      });
    }
  }

  @override
  void initState() {
    _profileUpdateController.enable.value = false;
    _nameController =
        TextEditingController(text: AppConstanst.userData['name']);
    _emailController =
        TextEditingController(text: AppConstanst.userData['email']);
    _rollController =
        TextEditingController(text: AppConstanst.userData['rollNo']);
    _nameController.addListener(() {
      if (_nameController.text != AppConstanst.userData['name']) {
        _profileUpdateController.enable.value = true;
      } else {
        _profileUpdateController.enable.value = false;
      }
    });

    _rollController.addListener(() {
      if (_emailController.text != AppConstanst.userData['email']) {
        _profileUpdateController.enable.value = true;
      } else {
        _profileUpdateController.enable.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () =>
                        _profileUpdateController.uploadImageAndUpdateUser(
                            FirebaseAuth.instance.currentUser!.uid),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 50,
                      child: _profileUpdateController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : AppConstanst.userData['image'] == null
                              ? const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 60.0,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Image.network(
                                    AppConstanst.userData['image'],
                                    fit: BoxFit.fill,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  labelText: 'Name',
                  textInputType: TextInputType.text,
                  controller: _nameController,
                  borderColor: Colors.green,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'Roll number',
                  textInputType: TextInputType.number,
                  controller: _rollController,
                  borderColor: Colors.green,
                ),
                const SizedBox(height: 40),
                AbsorbPointer(
                  absorbing: true,
                  child: CustomTextField(
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    borderColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 40),
                Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _profileUpdateController.enable.value
                            ? () async{
                                showDialog(context: context, builder: (context){
                                  return const Center(child: CircularProgressIndicator(),);
                                });
                                await _profileUpdateController
                                    .updateProfile(_nameController.text,
                                        _rollController.text)
                                    .then((value) {
                                  if (value) {
                                    Get.snackbar('Success',
                                        'Profile updated successfully');
                                  } else {
                                    Get.snackbar('Error',
                                        'Profile update failed');
                                  }

                                });
                                Navigator.pop(context);
                        }
                            : null,
                        child: const Text('Update Profile'))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
