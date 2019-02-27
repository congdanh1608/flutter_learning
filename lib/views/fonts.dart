import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyFonts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Using the Raleway font from...",
          style: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
      ),
    );
  }
}
