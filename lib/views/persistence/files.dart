import 'package:flutter/material.dart';
import 'package:flutter_learning/views/persistence/bloc/file_bloc.dart';

class MyFiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFiles();
  }
}

class _MyFiles extends State<MyFiles> {
  final bloc = FileBloc();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
            bloc.writeCounter(_counter);
          });
        },
        tooltip: 'Increase',
        child: Icon(Icons.add),
      ),
      body: Center(
          child: StreamBuilder(
              stream: bloc.counter,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _counter = snapshot.data;
                  return Text('counter: $_counter');
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
