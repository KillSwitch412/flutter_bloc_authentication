import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
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
    required Map<dynamic, dynamic> loginData,
  }) async {
    return await authenticationAPI.login(loginData: loginData);
  }

  // Future<bool> isTokenValid

  Future<void> deleteData() async {
    await _secureStorage.deleteAll();
  }

  Future<void> persistData(token) async {
    // storing token to secure_storage
    await _secureStorage.write(key: 'JWT_TOKEN', value: token);

    // storing data to shared storage
    _sharedStorage.setString('FIRSTNAME', 'value');
    _sharedStorage.setString('LASTNAME', 'value');
  }

  // * needed for app starts
  Future<bool> hasValidToken() async {
    // 1) get token from local storage
    final String token = await _secureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    // 2) validate token from server
    try {
      // request
      final validationResponce = await authenticationAPI.isTokenValid(
        token: token,
      );

      // check response
      if (validationResponce.data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      // incase of error
      Logger().d("Error in 'UserRepositoty.hasValidToken()': $err");
      return false;
    }
  }
}
