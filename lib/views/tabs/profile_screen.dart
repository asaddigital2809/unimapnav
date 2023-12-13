import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimapnav/util/app_constants.dart';
import 'package:unimapnav/views/aauth/view_profile.dart';
import 'package:unimapnav/views/passwords/password.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserController _userController;

  ImageProvider? _profileImage;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                  // backgroundImage: _profileImage ??
                  //     const AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.grey[300],
                  radius: 50,
                  child: AppConstanst.userData['image'] == null
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
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppConstanst.userData['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(AppConstanst.userData['email']),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text('View Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewProfileScreen())).then((value){
                          setState(() {

                          });
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.lock_reset,
              ),
              title: const Text('Reset Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Change Password'),
                      content: const Text('You will receive an email to reset your password'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            _userController.resetPassword(AppConstanst.userData['email']);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // ... your existing code ...

            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: const Text('Logout'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            _userController.signOut(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
