import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:traininggroupproject/assets/images';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Stack(
        children: [
          Container(
            // Background Image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/topmask.png'),
                opacity: 0.1,
                alignment: Alignment(0.0, -1),
              ),
            ),
          ),
          //Text
          const Text("hello You"),
          //avatar Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25 - 25,
            left: MediaQuery.of(context).size.width * 0.5,
            child: IconButton(
              icon: Image.asset('images/avatar.png'),
              onPressed: () {
                print("Hello");
              },
            ),
          ),
        ],
      ),
    );
  }
}
