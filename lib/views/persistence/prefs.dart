import 'package:flutter/material.dart';
import 'package:flutter_learning/views/persistence/prefs_helper.dart';

class MySharedPreferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SharePreferences();
  }
}

class _SharePreferences extends State<MySharedPreferences> {
  final String COUNTER = 'counter';

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    _counter = await SharedPreferencesHelper.getCounter();
    setState(() {});
  }

  _increaseCounter() async {
    _counter++;
    await SharedPreferencesHelper.setCounter(_counter);
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times'),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: RaisedButton(
              onPressed: () {
                _increaseCounter();
              },
              child: Text('Increase'),
            ),
          )
        ],
      ),
    );
  }
}
