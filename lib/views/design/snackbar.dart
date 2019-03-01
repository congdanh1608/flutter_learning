import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: RaisedButton(
        onPressed: () {
          _onPressed(context);
        },
        child: Text("Show SnackBar"),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    final _snackBar = SnackBar(
      content: Text("Yay! A SnackBar"),
      action: SnackBarAction(
          label: "Close",
          onPressed: () {
            print("SnackBar action!");
          }),
    );

    Scaffold.of(context).showSnackBar(_snackBar);
  }
}
