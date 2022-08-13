import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/auth_api.dart';

class UserRepository {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> register({
    required Map<dynamic, dynamic> registerData,
  }) async {
    return await authenticationAPI.register(registerData: registerData);
  }

  Future<dynamic> signin({
    required Map<dynamic, dynamic> signinData,
  }) async {
    return await authenticationAPI.sigin(signinData: signinData);
  }

  Future<void> deleteData() async {
    await _storage.deleteAll();
  }

  Future<void> persistData(token) async {
    await _storage.write(key: 'JWT_TOKEN', value: token);
  }

  Future<bool> hasToken() async {
    final String token = await _storage.read(key: 'JWT_TOKEN') ?? '';
    return token == '' ? false : true;
  }
}
