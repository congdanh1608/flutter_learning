import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_learning/images/image_loading.dart';
import 'package:flutter_learning/views/animation/fade_in_out.dart';
import 'package:flutter_learning/views/design/add_drawer.dart';
import 'package:flutter_learning/views/design/fonts.dart';
import 'package:flutter_learning/views/design/orientation_list.dart';
import 'package:flutter_learning/views/design/snackBar.dart';
import 'package:flutter_learning/views/design/tabs.dart';
import 'package:flutter_learning/views/forms/custom_form.dart';
import 'package:flutter_learning/views/forms/text_field.dart';
import 'package:flutter_learning/views/gestures/inkwell.dart';
import 'package:flutter_learning/views/gestures/swipe.dart';
import 'package:flutter_learning/views/lists/basic_list.dart';
import 'package:flutter_learning/views/lists/grid_list.dart';
import 'package:flutter_learning/views/lists/horizontal_list.dart';
import 'package:flutter_learning/views/lists/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Cookbook",
      theme: new ThemeData(
          primaryColor: Colors.lightBlue[500],
          brightness: Brightness.dark,
          accentColor: Colors.cyan,
          fontFamily: 'Raleway',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'TrajanPro'),
            body2: TextStyle(fontSize: 12.0, fontFamily: 'TrajanPro'),
          )),
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
        type.toString() + ". " + list[type].value,
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
    itemList[5] = "Updating the UI based on orientation";
    itemList[6] = "Working with Tabs";
    itemList[7] = "Building a form with validation";
    itemList[8] = "Create, style and focus a text field";
    itemList[9] = "Adding Material Touch Ripples";
    itemList[10] = "Implement Swipe to Dismiss";
    itemList[11] = "Display images";
    itemList[12] = "Basic List";
    itemList[13] = "Horizontal List";
    itemList[14] = "Grid List";
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
        return RandomWords();
      case 1:
        return FadeInOut();
      case 2:
        return MyAddDrawer();
      case 3:
        return MySnackBar();
      case 4:
        return MyFonts();
      case 5:
        return OrientationList();
      case 6:
        return MyTabBar();
      case 7:
        return MyCustomForm();
      case 8:
        return MyTextField();
      case 9:
        return MyInkWell();
      case 10:
        return MySwipe();
      case 11:
        return MyImage();
      case 12:
        return BasicList();
      case 13:
        return HorizontalList();
      case 14:
        return GridList();
    }
  }
}
