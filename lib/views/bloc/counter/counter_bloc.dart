import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/counter_event.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increase:
        yield currentState + 1;
        break;
      case CounterEvent.decrease:
        yield currentState - 1;
        break;
    }
  }
}
