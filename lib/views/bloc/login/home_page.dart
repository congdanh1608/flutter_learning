import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/login/bloc/authentication_bloc.dart';
import 'package:flutter_learning/views/bloc/login/event/authentication_event.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBlo = BlocProvider.of(context);

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _authenticationBlo.dispatch(LoggedOut());
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
