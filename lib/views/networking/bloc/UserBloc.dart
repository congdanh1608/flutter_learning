import 'package:flutter_learning/views/networking/model/user.dart';
import 'package:flutter_learning/views/networking/repository/UserRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject = BehaviorSubject<UserResponse>();

  getUser() async {
    UserResponse response = await _repository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject {
    return _subject;
  }
}

final bloc = UserBloc();
