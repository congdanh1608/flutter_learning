import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen();
            }));
          },
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'myhero',
                  child: RaisedButton(
                      child: Text('Go'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailScreen();
                        }));
                      }),
                ),
              ],
            ),
          )),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
            child: Hero(
          tag: 'myhero',
          child: RaisedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              }),
        )),
      ),
    );
  }
}
