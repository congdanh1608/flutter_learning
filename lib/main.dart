import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_learning/views/addDrawer.dart';
import 'package:flutter_learning/views/fadeInOut.dart';
import 'package:flutter_learning/views/fonts.dart';
import 'package:flutter_learning/views/list.dart';
import 'package:flutter_learning/views/snackBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Cookbook",
      theme: new ThemeData(primaryColor: Colors.blue),
      home: Cookbook(),
    );
  }
}

class Cookbook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CookbookState();
  }
}

class CookbookState extends State<Cookbook> {
  final Map<int, String> itemList = new HashMap();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cookbook"),
      ),
      body: _buildCookbookContent(),
    );
  }

  Widget _buildCookbookContent() {
    //generate data for list view
    _generateData();

    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: itemList.length,
        itemBuilder: (context, i) {
          return _buildRows(i);
        });
  }

  Widget _buildRows(int type) {
    var list = itemList.entries.toList();
    return new ListTile(
      title: Text(
        list[type].value,
        style: _biggerFont,
      ),
      trailing: new Icon(Icons.navigate_next),
      onTap: () {
        _onItemTap(list[type].key);
      },
    );
  }

  void _generateData() {
    itemList[0] = "First demo";
    itemList[1] = "Fade a Widget in and out";
    itemList[2] = "Add a Drawer to a screen";
    itemList[3] = "Displaying SnackBars";
    itemList[4] = "Exporting fonts from a package";
  }

  void _onItemTap(int type) {
    var list = itemList.entries.toList();
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(list[type].value),
        ),
        body: getView(type),
      );
    }));
  }

  getView(int type) {
    switch (type) {
      case 0:
        return new RandomWords();
      case 1:
        return new FadeInOut();
      case 2:
        return new MyAddDrawer();
      case 3:
        return new MySnackBar();
      case 4:
        return new MyFonts();
    }
  }
}
