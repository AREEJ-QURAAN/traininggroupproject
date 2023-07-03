import 'package:flutter/material.dart';
import 'package:traininggroupproject/views/profile_view.dart';

////
////ROUTES : -------------------
const profileRoute = '/profile/';
////ROUTES : -------------------
///
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(profileRoute);
        },
        child: const Icon(Icons.accessibility),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
