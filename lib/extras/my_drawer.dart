import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
            title: const Text('Flutter for Android'),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);
              //view screen
              Navigator.pushNamed(
                context,
                'flutter_for_android',
              );
            }),
        ListTile(
            title: const Text('Database'),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);
              //view screen
              Navigator.pushNamed(
                context,
                'database',
              );
            }),
        ListTile(
            title: const Text('Animation'),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);
              //view screen
              Navigator.pushNamed(
                context,
                'animated',
              );
            }),
      ],
    ));
  }
}
