import 'package:bloc/bloc.dart';
import 'package:flutter_learning/views/bloc/login/bloc/authentication_bloc.dart';
import 'package:flutter_learning/views/bloc/login/event/authentication_event.dart';
import 'package:flutter_learning/views/bloc/login/event/login_event.dart';
import 'package:flutter_learning/views/bloc/login/repository/user_repository.dart';
import 'package:flutter_learning/views/bloc/login/state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository, this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(username: event.username, password: event.password);

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
