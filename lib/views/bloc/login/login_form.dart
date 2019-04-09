import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/login/bloc/authentication_bloc.dart';
import 'package:flutter_learning/views/bloc/login/bloc/login_bloc.dart';
import 'package:flutter_learning/views/bloc/login/event/login_event.dart';
import 'package:flutter_learning/views/bloc/login/state/login_state.dart';

class LoginForm extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;
  final LoginBloc loginBloc;

  const LoginForm({Key key, this.authenticationBloc, this.loginBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
              ),
              RaisedButton(
                onPressed: () {
                  state is! LoginLoading ? _onLoginButtonPressed() : null;
                },
                child: Text('Login'),
              ),
              Container(
                child: state is LoginLoading ? CircularProgressIndicator() : null,
              )
            ],
          ),
        );
      },
    );
  }

  _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
