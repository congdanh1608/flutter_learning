import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/views/bloc/infinite_list/simple_bloc_delegate.dart';
import 'package:flutter_learning/views/bloc/login/bloc/authentication_bloc.dart';
import 'package:flutter_learning/views/bloc/login/event/authentication_event.dart';
import 'package:flutter_learning/views/bloc/login/home_page.dart';
import 'package:flutter_learning/views/bloc/login/loding_indicator.dart';
import 'package:flutter_learning/views/bloc/login/login_page.dart';
import 'package:flutter_learning/views/bloc/login/repository/user_repository.dart';
import 'package:flutter_learning/views/bloc/login/splash_page.dart';
import 'package:flutter_learning/views/bloc/login/state/authentication_state.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() {
    BlocSupervisor().delegate = SimpleBlocDelegate();
    return _AppPageState();
  }
}

class _AppPageState extends State<AppPage> {
  UserRepository userRepository;
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    userRepository = UserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: authenticationBloc,
      child: BlocBuilder(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(
                userRepository: userRepository,
              );
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          }),
    );
  }
}
