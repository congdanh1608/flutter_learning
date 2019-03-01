import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyFonts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Using the Raleway font from...",
              style: TextStyle(
                fontFamily: 'Raleway',
              ),
            ),
            Text(
              "Using the Raleway font italic",
              style: TextStyle(
                fontFamily: 'Raleway',
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "Using the Raleway font bold",
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Using the TrajanPro font",
              style: TextStyle(
                fontFamily: 'TrajanPro',
              ),
            ),
            Text(
              "Using the TrajanPro font bold",
              style: TextStyle(
                fontFamily: 'TrajanPro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
