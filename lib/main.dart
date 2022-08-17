import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'data/repositories/user_repository.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // * providing instance of UserRepo
  runApp(App(userRepository: UserRepository()));
}

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
