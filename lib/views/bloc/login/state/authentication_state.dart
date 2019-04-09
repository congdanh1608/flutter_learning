import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Uninitialized';
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Authenticated';
  }
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Unauthenticated';
  }
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return 'Authentication Loading';
  }
}
