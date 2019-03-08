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
              _navigateAndWaitForResult(context);
            }),
      ),
    );
  }

  _navigateAndWaitForResult(context) async {
    dynamic result = await Navigator.pushNamed(context, '/nextScreen', arguments: new Test('Pass data from 1 to 2')); //pass data by arguments
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(result.title)));
  }
}

class MyNextRouteNavigation extends StatelessWidget {
  final Test test;

  const MyNextRouteNavigation({Key key, @required this.test}) : super(key: key); //create with data was received in generate Route.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Route Navigation'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Text(
            test.title,
            style: TextStyle(color: Colors.red, fontSize: 18.0),
          ),
          RaisedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context, Test("Return data from 2 to 1"));
              }),
        ],
      )),
    );
  }
}

class Test {
  final String title;

  Test(this.title);
}
