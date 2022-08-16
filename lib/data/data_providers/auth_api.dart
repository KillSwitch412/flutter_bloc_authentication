import 'package:dio/dio.dart';

class AuthenticationAPI {
  final String baseUrl = 'http://192.168.8.130:3000/api/v1/users';

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

  // Future<bool> isTokenValid
}
