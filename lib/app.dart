import 'package:bloc_authentication/presentation/screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      home: AuthScreen(),
    );
  }
}
