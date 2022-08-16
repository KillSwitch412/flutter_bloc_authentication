import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_providers/auth_api.dart';

class UserRepository {
  UserRepository() {
    initializeSharedStorage();
  }

  final AuthenticationAPI authenticationAPI = AuthenticationAPI();
  final _secureStorage = const FlutterSecureStorage();
  late SharedPreferences _sharedStorage;

  Future initializeSharedStorage() async {
    _sharedStorage = await SharedPreferences.getInstance();
  }

  // on registering
  Future<dynamic> registerAndAuthenticate({
    required Map<dynamic, dynamic> registerData,
  }) async {
    return await authenticationAPI.register(registerData: registerData);
  }

  // on logging in
  Future<dynamic> authenticate({
    required Map<dynamic, dynamic> signinData,
  }) async {
    return await authenticationAPI.sigin(signinData: signinData);
  }

  // Future<bool> isTokenValid

  Future<void> deleteData() async {
    await _secureStorage.deleteAll();
  }

  Future<void> persistData(token) async {
    // storing token to secure_storage
    await _secureStorage.write(key: 'KEY_TOKEN', value: token);

    // storing data to shared storage
    _sharedStorage.setString('FIRSTNAME', 'value');
    _sharedStorage.setString('LASTNAME', 'value');
  }

  Future<bool> hasToken() async {
    final String token = await _secureStorage.read(key: 'JWT_TOKEN') ?? '';
    return token == '' ? false : true;
  }
}
