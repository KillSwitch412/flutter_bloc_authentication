import 'package:dio/dio.dart';

import '../../constants/url.dart';

class AuthenticationAPI {
  final String baseUrl = '$url/api/v1/users';

  Future<dynamic> register({
    required Map<dynamic, dynamic> registerData,
  }) async {
    return await Dio().post('$baseUrl/register', data: registerData);
  }

  Future<dynamic> login({
    required Map<dynamic, dynamic> loginData,
  }) async {
    return await Dio().post('$baseUrl/signin', data: loginData);
  }

  Future<dynamic> isTokenValid({required String token}) async {
    return await Dio().post(
      '$baseUrl/validateLogin',
      options: Options(headers: {"authorization": token}),
    );
  }
}
