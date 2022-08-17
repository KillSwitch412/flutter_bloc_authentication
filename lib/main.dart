import 'package:bloc_authentication/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';

import 'app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // * providing instance of UserRepo
  runApp(App(userRepository: UserRepository()));
}

// TODO: add functionality to verify token from server while logging in
// TODO: add registering functionality

// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//   HydratedBlocOverrides.runZoned(
//     () => runApp(const App()),
//     storage: await HydratedStorage.build(
//       storageDirectory: await getApplicationDocumentsDirectory(),
//     ),
//   );
// }
