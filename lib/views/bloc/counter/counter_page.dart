import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/counter_bloc.dart';
import 'package:flutter_learning/views/bloc/counter_event.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
        body: BlocBuilder(
          bloc: _counterBloc,
          builder: (BuildContext context, int count) {
            return Center(
              child: Text(
                "$count",
                style: Theme.of(context).textTheme.headline,
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: FloatingActionButton(
                heroTag: "1",
                onPressed: () {
                  _counterBloc.dispatch(CounterEvent.increase);
                },
                child: Icon(Icons.add),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: FloatingActionButton(
                heroTag: "2",
                onPressed: () {
                  _counterBloc.dispatch(CounterEvent.decrease);
                },
                child: Icon(Icons.remove),
              ),
            ),
          ],
        ));
  }
}
