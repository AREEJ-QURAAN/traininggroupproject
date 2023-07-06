import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helper/dataformatter.dart';
import 'dialogs.dart';
// import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _selectedImage;
  DateTime? _selectedDate;
  late final TextEditingController _dateTxtC;
  @override
  initState() {
    _dateTxtC =
        TextEditingController(text: LocalDateFormat.format(DateTime.now()));
    super.initState();
  }

  @override
  dispose() {
    _dateTxtC.dispose();
    super.dispose();
  }

  //_selectDate
  Future<void> _selectDate() async {
    final DateTime? pickerDte = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickerDte != null) {
      setState(() {
        _selectedDate = pickerDte;
      });
    }
  }

//_select avatar
  Future<void> _pickImageFromGallery() async {
    // Check if permission is granted
    PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } else if (status.isDenied) {
      final shouldOpenGalary = await showPermissionDialog(context);
      if (shouldOpenGalary) {
        // OpenGalary
        _pickImageFromGallery();
      } else {
        Navigator.of(context).pop();
      }
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/topmask.png'),
                  fit: BoxFit.fitWidth,
                  opacity: 0.3,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),

            //   left: MediaQuery.of(context).size.width * 0.5 - avatarWidth * 0.5,
            const SizedBox(height: 100), //just space between items
            CircleAvatar(
              backgroundColor: Colors.purple,
              radius: avatarWidth / 2,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider<Object>
                  : const AssetImage('images/avatar.png'),
              child: IconButton(
                iconSize: 1,
                icon: const Icon(Icons.camera_alt),
                onPressed: _pickImageFromGallery,
              ),
            ),
            //----------
            const SizedBox(height: 10), //just space between items
            const Text('Welcome User Name'),
            const SizedBox(height: 10), //just space between items
            SizedBox(
              width: 250,
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Select Date Of Birth',
                  fillColor: Colors.amber,
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate();
                },
                // controller: TextEditingController(
                //   text: _selectedDate != null
                //       ? LocalDateFormat.format(_selectedDate!)
                //       : LocalDateFormat.format(DateTime.now()),
                // ),
                controller: _dateTxtC,
              ),
            ),
          ],
        )
        // Stack(
        //   children: [
        // Container(
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('images/topmask.png'),
        //       fit: BoxFit.fitWidth,
        //       opacity: 0.3,
        //       alignment: Alignment.topCenter,
        //     ),
        //   ),
        // ),

        // Positioned(
        //   left: MediaQuery.of(context).size.width * 0.5 - avatarWidth * 0.5,
        //   top: avatarWidth - 20,
        //   child:
        //   ,
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         //   left: MediaQuery.of(context).size.width * 0.5 - avatarWidth * 0.5,
        //         const SizedBox(height: 100), //just space between items
        //         CircleAvatar(
        //           backgroundColor: Colors.purple,
        //           radius: avatarWidth / 2,
        //           backgroundImage: _selectedImage != null
        //               ? FileImage(_selectedImage!) as ImageProvider<Object>
        //               : const AssetImage('images/avatar.png'),
        //           child: IconButton(
        //             iconSize: 1,
        //             icon: const Icon(Icons.camera_alt),
        //             onPressed: _pickImageFromGallery,
        //           ),
        //         ),
        //         //----------
        //         const SizedBox(height: 10), //just space between items
        //         const Text('Welcome User Name'),
        //         const SizedBox(height: 10), //just space between items
        //         SizedBox(
        //           width: 250,
        //           child: TextField(
        //             readOnly: true,
        //             decoration: const InputDecoration(
        //               labelText: 'Select Date Of Birth',
        //               fillColor: Colors.amber,
        //               border: OutlineInputBorder(),
        //             ),
        //             onTap: () {
        //               _selectDate();
        //             },
        //             // controller: TextEditingController(
        //             //   text: _selectedDate != null
        //             //       ? LocalDateFormat.format(_selectedDate!)
        //             //       : LocalDateFormat.format(DateTime.now()),
        //             // ),
        //             controller: _dateTxtC,
        //           ),
        //         ),
        //       ],
        //     )
        //     // ),
        //   ],
        // ),
        );
  }
}
