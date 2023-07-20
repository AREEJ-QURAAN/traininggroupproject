import 'package:flutter/material.dart';
import 'package:traininggroupproject/views/map_view.dart';
import 'package:traininggroupproject/views/profile_view.dart';
import '../helper/constants.dart';

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
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:

          ///It's important to note that using SingleChildScrollView with a large
          ////// amount of content can impact performance because it renders and
          //////lays out all the child widgets at once. If you have a long list or
          //////a large amount of content, you should consider using widgets
          ////// like ListView or GridView for better performance, as they only
          ////// render and layout the visible portion of the content.
          // SingleChildScrollView(
          //   child:
          ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemsToDo.length,
        itemBuilder: (context, index) {
          final item = itemsToDo[index].keys.first;
          final action = itemsToDo[index].values.first;
          return ListTile(
            trailing: const Icon(Icons.info),
            style: ListTileStyle.drawer,
            subtitle: const Text('subtitle'),
            title: Text(item),
            textColor: themeColor,
            iconColor: themeColorUnfocusedBorders,
            selectedTileColor: themeColorLocation,
            onTap: () {
              action.call(context);
            },
          );
        },
      ),
      // ),
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
