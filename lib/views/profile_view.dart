import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _selectedImage;
  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarWidth = MediaQuery.of(context).size.width *
        (288.0 / 744) *
        (744 * 0.5 / MediaQuery.of(context).size.width);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/topmask.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5 - avatarWidth * 0.5,
            top: avatarWidth - 20,
            child: Column(
              children: [
                IconButton(
                  iconSize: avatarWidth,
                  icon: _selectedImage != null
                      ? Image.file(_selectedImage!)
                      : Image.asset('images/avatar.png'),
                  onPressed: _pickImageFromGallery,
                ),
                //----------
                const Text('Welcome User Name'),
                _selectedImage != null
                    ? CircleAvatar(
                        radius: avatarWidth * 0.5,
                        backgroundImage: FileImage(_selectedImage!),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 100 * 0.50,
                        child: Image.asset('images/avatar.png'),
                      ),
                const SizedBox(height: 0), //just space between items
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(0, 45, 12, 88),
                  ),
                  child: const Text('Select Image'),
                ),
                const SizedBox(height: 20), //just space between items
                const Text("user sr family "),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
