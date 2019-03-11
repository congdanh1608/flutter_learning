import 'package:flutter_learning/views/networking/model/user.dart';
import 'package:flutter_learning/views/networking/provider/user_api_provider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser() {
    return _apiProvider.getUser();
  }
}
