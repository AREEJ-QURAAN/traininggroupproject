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
            decoration: const BoxDecoration(
              // color: Color.fromARGB(122, 39, 141, 141),
              image: DecorationImage(
                image: AssetImage('images/topmask.png'),
                opacity: 0.1,
                // fit: BoxFit.none,
                alignment: Alignment(0.0, -1),
              ),
            ),
          ),
          const Text("hello"),
          Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.abc),
            ),
          ),
        ],
      ),
    );
  }
}
