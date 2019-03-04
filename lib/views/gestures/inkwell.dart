import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInkWell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyButton(),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Tap")),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.all(12.0),
        child: Text("Flat Button"),
      ),
    );
  }
}
