import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            onTap: () => (Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Clicked!')))),
            leading: Icon(Icons.map),
            title: Text('Map'),
          ),
          ListTile(
            leading: Icon(Icons.album),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          )
        ],
      ),
    );
  }
}
