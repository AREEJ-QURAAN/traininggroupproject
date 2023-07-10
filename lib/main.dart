import 'package:flutter/material.dart';
import 'package:traininggroupproject/views/map_view.dart';
import 'package:traininggroupproject/views/profile_view.dart';

////
////ROUTES : -------------------
const profileRoute = '/profile/';
const mapViewRoute = '/map_view/';

////ROUTES : -------------------
///
///////Items TO DO LIST : -------------------
List<Map<String, Function(dynamic)>> itemsToDo = [
  {
    'Profile': (context) {
      Navigator.of(context).pushNamed(profileRoute);
    },
  },
  {
    'Item 2': (parameter) {
      // Action for Item 2
      print('Item 2 selected');
    },
  },
  {
    'Item 3': (parameter) {
      // Action for Item 3
      print('Item 3 selected');
    },
  },
  // Add more items as needed
];
///////Items TO DO LIST : ---------------------------------------------------------

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Training Group Project',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(title: 'Flutter Demo Home Page'),
    routes: {
      profileRoute: (context) => const ProfileView(),
      mapViewRoute: (context) => const MapScreen(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemsToDo.length,
          itemBuilder: (context, index) {
            final item = itemsToDo[index].keys.first;
            final action = itemsToDo[index].values.first;
            return ListTile(
              title: Text(item),
              onTap: () {
                action.call(context);
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(profileRoute);
      //   },
      //   child: const Icon(Icons.accessibility),
      //   backgroundColor: Colors.blueGrey,
      // ),
    );
  }
}
