import 'package:flutter/material.dart';

class MyAddDrawer extends StatelessWidget {
  final String title;

  MyAddDrawer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Drawer"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Drawer Header"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text("Item 1"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Item 2"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Back"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
