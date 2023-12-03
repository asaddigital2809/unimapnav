import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimapnav/views/aauth/view_profile.dart';
import 'package:unimapnav/views/passwords/password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    // backgroundImage: _profileImage ??
                    //     const AssetImage('assets/images/profile.png'),
                    backgroundColor: Colors.grey[300],
                    radius: 50,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 60.0,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('abc@gmail.com'),
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
                builder: (context) => ViewProfileScreen(

                )
                )
                );

              },
            ),
            const SizedBox(
              height: 10,
            ),
             ListTile(
              leading: Icon(
                Icons.lock_reset,
              ),
              title: Text('Reset Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordScreen()
                  )
              );},
            ),
            const SizedBox(
              height: 10,
            ),
            // ... your existing code ...

             ListTile(
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward_ios),
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
