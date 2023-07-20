import 'package:flutter/material.dart';
import 'package:traininggroupproject/views/map_view.dart';
import 'package:traininggroupproject/views/profile_view.dart';
import 'package:traininggroupproject/views/home_page.dart';
import '../helper/constants.dart';

////
////ROUTES : -------------------
const profileRoute = '/profile/';
const mapViewRoute = '/map_view/';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 1; // The index of the current tab Home

// List of views for the bottom navigation bar tabs
  final List<Widget> _views = const [
    ProfileView(),
    HomePage(title: 'Flutter Demo Home Page'),
    MapScreen(),
  ];
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Location',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training Group Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // MaterialColor(themeColor.value, {50: themeColor.withOpacity(0.1)}),
      ),
      routes: {
        profileRoute: (context) => const ProfileView(),
        mapViewRoute: (context) => const MapScreen(),
      },
      // home: const HomePage(title: 'Flutter Demo Home Page'),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('My App'),
        // ),
        body: _views[_currentIndex], // Display the current tab's view
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index; // Change the tab when tapped
              });
            },
            items: items),
      ),
    );
  }
}
//-------------------------------------------------------------------------------
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//     title: 'Flutter Training Group Project',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//       // MaterialColor(themeColor.value, {50: themeColor.withOpacity(0.1)}),
//     ),
//     home: const HomePage(title: 'Flutter Demo Home Page'),
//     routes: {
//       profileRoute: (context) => const ProfileView(),
//       mapViewRoute: (context) => const MapScreen(),
//     },
//   ));
// }


////ROUTES : -------------------
///
///
// ///////Items TO DO LIST : -------------------
// List<Map<String, Function(dynamic)>> itemsToDo = [
//   {
//     'Profile': (context) {
//       Navigator.of(context).pushNamed(profileRoute);
//     },
//   },
//   {
//     'Item 2': (parameter) {
//       // Action for Item 2
//       print('Item 2 selected');
//     },
//   },
//   {
//     'Item 3': (parameter) {
//       // Action for Item 3
//       print('Item 3 selected');
//     },
//   },
//   // Add more items as needed
// ];
///////Items TO DO LIST : ---------------------------------------------------------
// class HomePage extends StatelessWidget {
//   const HomePage({super.key, required this.title});
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body:

//           ///It's important to note that using SingleChildScrollView with a large
//           ////// amount of content can impact performance because it renders and
//           //////lays out all the child widgets at once. If you have a long list or
//           //////a large amount of content, you should consider using widgets
//           ////// like ListView or GridView for better performance, as they only
//           ////// render and layout the visible portion of the content.
//           // SingleChildScrollView(
//           //   child:
//           ListView.builder(
//         physics: const AlwaysScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: itemsToDo.length,
//         itemBuilder: (context, index) {
//           final item = itemsToDo[index].keys.first;
//           final action = itemsToDo[index].values.first;
//           return ListTile(
//             trailing: const Icon(Icons.info),
//             style: ListTileStyle.drawer,
//             subtitle: const Text('subtitle'),
//             title: Text(item),
//             textColor: themeColor,
//             iconColor: themeColorUnfocusedBorders,
//             selectedTileColor: themeColorLocation,
//             onTap: () {
//               action.call(context);
//             },
//           );
//         },
//       ),
//       // ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Navigator.of(context).pushNamed(profileRoute);
//       //   },
//       //   child: const Icon(Icons.accessibility),
//       //   backgroundColor: Colors.blueGrey,
//       // ),
//     );
//   }
// }
