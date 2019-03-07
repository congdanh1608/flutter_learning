import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRouteNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
            child: Text('Gooooo....'),
            onPressed: () {
              Navigator.pushNamed(context, '/nextScreen', arguments: new Test('123'));
            }),
      ),
    );
  }
}

class MyNextRouteNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Route Navigation'),
      ),
      body: Container(
        child: RaisedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}

class Test {
  final String title;

  Test(this.title);
}
