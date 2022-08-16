import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF333333),
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
