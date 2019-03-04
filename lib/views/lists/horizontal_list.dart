import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160.0,
            color: Colors.red,
          ),
          Container(
            width: 160.0,
            color: Colors.white,
          ),
          Container(
            width: 160.0,
            color: Colors.yellow,
          ),
          Container(
            width: 160.0,
            color: Colors.blue,
          ),
          Container(
            width: 160.0,
            color: Colors.indigo,
          ), Container(
            width: 160.0,
            color: Colors.cyan,
          ), Container(
            width: 160.0,
            color: Colors.pink,
          ),
          Container(
            width: 160.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
