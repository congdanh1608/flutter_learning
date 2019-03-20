import 'dart:async';

import 'package:flutter/material.dart';

class IntegrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntegrationTesting(),
    );
  }
}

class IntegrationTesting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntegrationTesting();
  }
}

class _IntegrationTesting extends State<IntegrationTesting> {
  int _counter = 0;

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intergration Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('you have pushed the button this many times:'),
            Text(
              '$_counter',
              key: Key('counter'),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        key: Key('increment'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
