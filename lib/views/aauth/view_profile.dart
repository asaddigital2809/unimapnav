import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimapnav/widgets/custom_textfield.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ImageProvider? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = FileImage(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundImage: _profileImage ?? const AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.grey[300],
                  radius: 50,
                  child: _profileImage == null
                      ? const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 60.0,
                  )
                      : const SizedBox(height: 20,),
                ),
              ),
              const SizedBox(height: 40,),
              CustomTextField(
                labelText: 'Name',
                textInputType: TextInputType.text,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Roll number',
                textInputType: TextInputType.number,
                borderColor: Colors.green,
              ),
              const SizedBox(height:40),
              CustomTextField(
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
                borderColor: Colors.green,
              ),
              const SizedBox(height: 40),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, child: const Text('Update Profile')))
            ],
          ),
        ),
      ),
    );
  }
}
