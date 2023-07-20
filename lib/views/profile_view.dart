import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traininggroupproject/main.dart';
import '../helper/dataformatter.dart';
import '../helper/constants.dart';
import 'dialogs.dart';
import 'package:app_settings/app_settings.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:intl/intl.dart';
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

const selectedImageKey = 'selectedImage';
const selectedDateOBKey = '_selectedDateOB';
const userLocationKey = '_userLocation';
const userGenderKey = '_userGender';

class _ProfileViewState extends State<ProfileView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  File? _selectedImage;
  DateTime? _selectedDateOB;
  TimeOfDay? _currentTime;
  String? _userLocation;
  String? _userGender;
  late final TextEditingController _dateTxtC;
  // late final TextEditingController _timeTxtC;
  @override
  initState() {
    // _timeTxtC.text = LocalTimeFormat.format(_currentTime!);
    _dateTxtC =
        TextEditingController(text: LocalDateFormat.format(DateTime.now()));
    readUserPrefs();
    super.initState();
  }

  void readUserPrefs() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _userGender = prefs.getString(userGenderKey);
      _userLocation = prefs.getString(userLocationKey);
      final _selectedImagePath = prefs.get(selectedImageKey).toString();
      _selectedImage = File(_selectedImagePath);
      final dOB = prefs.getString(selectedDateOBKey);
      if (dOB != null) {
        final formattedDate1 = DateTime.parse(dOB.replaceAll("/", "-"));
        final formattedDate =
            DateFormat("dd/MM/yyyy").parse(dOB); //this need int1 package
        setState(() {
          _selectedDateOB = formattedDate1;
          _dateTxtC.text = LocalDateFormat.format(_selectedDateOB!);
        });
      }
    });
  }

  void saveUserStringsPrefsForKey(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  @override
  dispose() {
    _dateTxtC.dispose();
    // _timeTxtC.dispose();
    super.dispose();
  }

//__selectLocation();
  Future<void> _showMapToSelectLocation() async {
    Navigator.of(context).pushNamed(mapViewRoute).then((value) {
      setState(() {
        _userLocation = value.toString();
        saveUserStringsPrefsForKey(userLocationKey, _userLocation!);
      });
    });
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
        _selectedDateOB = pickerDte;
        saveUserStringsPrefsForKey(selectedDateOBKey,
            LocalDateFormat.format(_selectedDateOB!).toString());
        _dateTxtC.text = LocalDateFormat.format(_selectedDateOB!);
      });
    }
  }

  Future<void> _setTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _currentTime = pickedTime;
        // _timeTxtC.text = LocalTimeFormat.format(_currentTime!);
        // _timeTxtC.text = DateFormat.Hm().format(DateTime(
        // 1, 1, 1, _currentTime?.hour ?? 0, _currentTime?.minute ?? 0));
      });
    }
  }

//_select avatar
  void showImageSourceActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Choose Your Profile Picture'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFrom(ImageSource.gallery, Permission.photos);
              },
              child: const Text('Choose From Galary'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _pickImageFrom(ImageSource.camera, Permission.camera);
                Navigator.of(context).pop();
              },
              child: const Text('Open Your Camera'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFrom(
      ImageSource source, Permission permissionFor) async {
    // Check if permission is granted

    PermissionStatus status = await permissionFor.request();
    bool test = true;
    if (status.isGranted || test) {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
          saveUserStringsPrefsForKey(
              selectedImageKey, pickedImage.path.toString());
        });
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      final shouldOpenSource = await showPermissionDialog(
        context,
        'Please change your setting and grant access to your camera/photos library so you can change your picture',
      );
      if (shouldOpenSource) {
        test = true;
        // OpenGalary
        AppSettings.openAppSettings().then((value) {
          _pickImageFrom(source, permissionFor);
        });
        //
      } else {
        test = true;
        // Navigator.of(context).pop();
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
              backgroundColor: themeColor,
              radius: avatarWidth / 2,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider<Object>
                  : const AssetImage('images/avatar.png'),
              child: IconButton(
                iconSize: 1,
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  showImageSourceActionSheet(context);
                },
              ),
            ),
            //----------

            const SizedBox(height: 10), //just space between items
            const Text('Welcome User Name'),
            const SizedBox(height: 50), //just space between items
            //---------------- gender ---------------- //
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: GenderDropdown(initWith: _userGender ?? 'Male'),
            ),
            const SizedBox(height: 16), //just space between items
            //---------------- TIME ---------------- //
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Time now ',
                  prefixIcon: Icon(Icons.punch_clock),
                  prefixIconColor: themeColorLocation,
                  labelStyle: TextStyle(color: themeColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColorUnfocusedBorders),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                ),
                controller: TextEditingController(
                    text: _currentTime != null
                        ? LocalTimeFormat.format(_currentTime!)
                        : 'set Time'),
                onTap: () {
                  _setTime();
                },
              ),
            ),
            const SizedBox(height: 16), //just space between items

            //---------------- Date ---------------- //
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                style: const TextStyle(color: themeColor),
                readOnly: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  prefixIconColor: themeColorCalander,
                  labelText: 'Select Date Of Birth',
                  labelStyle: TextStyle(color: themeColor),
                  // border: OutlineInputBorder(), //InputBorder.none
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColorUnfocusedBorders),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                ),
                onTap: () {
                  _selectDate();
                },
                controller: _dateTxtC,
              ),
            ),
            const SizedBox(height: 16), //just space between items
            //---------------- Location ---------------- //
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                  prefixIconColor: themeColorLocation,
                  labelStyle: TextStyle(color: themeColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColorUnfocusedBorders),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                ),
                controller: TextEditingController(
                    text: _userLocation ?? 'Your Location'),
                onTap: () {
                  _showMapToSelectLocation();
                },
              ),
            ),
            const SizedBox(height: 16), //just space between items
          ],
        ),
      ),
    );
  }
}

//--------TEST
class GenderDropdown extends StatefulWidget {
  final String initWith; // Accept the initial value as a parameter

  const GenderDropdown(
      {super.key,
      required this.initWith}); // Constructor to receive the initial value

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender = ''; // Default selected gender (nullable)

  @override
  void initState() {
    selectedGender = widget.initWith;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeColorUnfocusedBorders, // Choose your border color here
          width: 1.0, // Choose the border width here
        ),
        borderRadius:
            BorderRadius.circular(8.0), // Choose the border radius here
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            color: themeColor,
          ),
          const SizedBox(width: 10),
          const Text(
            'Select Your Gender:',
            style: TextStyle(fontSize: 16),
            selectionColor: themeColor,
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                items: <String>['Male', 'Female'].map((String item) {
                  return DropdownMenuItem(
                    alignment: AlignmentDirectional.center,
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                value: selectedGender,
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some trailing space (10 points)
        ],
      ),
    );
  }
}
