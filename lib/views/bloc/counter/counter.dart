import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/counter_bloc.dart';
import 'package:flutter_learning/views/bloc/counter_page.dart';

class MyCounter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyCounterState();
  }
}

class MyCounterState extends State<MyCounter> {
  final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: _counterBloc,
      child: CounterPage(),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}
