import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    ),
  );
}