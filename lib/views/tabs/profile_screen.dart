import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ImageProvider _profileImage =
      const NetworkImage('https://www.bing.com/ck/a?!&&p=8d37bb084ff9ef05JmltdHM9MTcwMTM4ODgwMCZpZ3VpZD0wMDM5ZTFjYi1jMTIzLTYxOGEtMjgyZS1mMzY1YzAyYTYwMzQmaW5zaWQ9NTQ3MA&ptn=3&ver=2&hsh=3&fclid=0039e1cb-c123-618a-282e-f365c02a6034&u=a1L2ltYWdlcy9zZWFyY2g_cT1pbWFnZXMmRk9STT1JUUZSQkEmaWQ9RUVDRkJCN0Y0MzIwOTIxNTcxQTUzOURCNDU5Q0FDRkU5RDFFQzI0Mg&ntb=1'); // Default image

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
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('name'),
            accountEmail: const Text('email'),
            currentAccountPictureSize: const Size.square(80),
            currentAccountPicture: GestureDetector(
              onTap: _pickImage,
              child: Stack(

                children: [
                  CircleAvatar(
                    backgroundImage: _profileImage,
                    backgroundColor: Colors.white38,
                    radius: 70,
                    child:  const Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size:60.0,
              ),
                  ),

                ],
              ),
            ),
            decoration: const BoxDecoration(color: Colors.grey),
          ),

          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.person,
            ),
            title: Text('View Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.lock_reset,
            ),
            title: Text('Reset Password'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.logout_outlined,
            ),
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
