import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traininggroupproject/main.dart';
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

//__selectLocation();
  Future<void> _showMapToSelectLocation() async {
    Navigator.of(context).pushNamed(mapViewRoute);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MapScreen()),
    // );
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
        _dateTxtC.text = LocalDateFormat.format(_selectedDate!);
      });
    }
  }

//_select avatar
  Future<void> _pickImageFromGallery() async {
    // Check if permission is granted
    PermissionStatus status = await Permission.photos.request();
    const test = true;
    if (status.isGranted || test) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } else if (status.isDenied) {
      final shouldOpenGalary = await showPermissionDialog(
        context,
        'Please grant access to your photo library to change your picture',
      );
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/topmask.png'),
              fit: BoxFit.fitWidth,
              opacity: 0.3,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration:
                      const BoxDecoration()), //HERE , if I remove this all alignment will be wrong

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
              const SizedBox(height: 50), //just space between items
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  style:
                      const TextStyle(color: Color.fromARGB(255, 89, 4, 105)),
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Select Date Of Birth',
                    labelStyle: TextStyle(color: Colors.green),
                    // border: OutlineInputBorder(), //InputBorder.none
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 130, 125, 125)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  onTap: () {
                    _selectDate();
                  },
                  controller: _dateTxtC,
                ),
              ),
              const SizedBox(height: 16), //just space between items
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                    labelStyle: TextStyle(color: Colors.green),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 130, 125, 125)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  controller: TextEditingController(text: 'Your Location'),
                  onTap: () {
                    _showMapToSelectLocation();
                  },
                ),
              ),
              const SizedBox(height: 16), //just space between items
            ],
          ),
        ));
  }
}
