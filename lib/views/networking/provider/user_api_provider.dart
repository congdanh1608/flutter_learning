import 'package:dio/dio.dart';
import 'package:flutter_learning/views/networking/model/user.dart';

class UserApiProvider {
  final String _endpoint = "https://randomuser.me/api/";
  final Dio _dio = Dio();

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print(stacktrace);
      return UserResponse.withError(error);
    }
  }
}
