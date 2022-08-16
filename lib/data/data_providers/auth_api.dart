import 'package:dio/dio.dart';

class AuthenticationAPI {
  final String baseUrl = 'http://10.0.2.2:3000/api/v1/users';

  Future<dynamic> register({
    required Map<dynamic, dynamic> registerData,
  }) async {
    return await Dio().post('$baseUrl/register', data: registerData);
  }

  Future<dynamic> sigin({
    required Map<dynamic, dynamic> signinData,
  }) async {
    return await Dio().post('$baseUrl/signin', data: signinData);
  }

  // Future<bool> isTokenValid
}
