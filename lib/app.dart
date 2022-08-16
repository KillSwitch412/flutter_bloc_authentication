import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';

import 'data/repositories/user_repository.dart';
import 'logic/bloc/authentication_bloc.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/screens/home_screen.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // * late authBloc
  late AuthenticationBloc authenticationBloc;
  // * getter
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    // * initializing authBloc with userRepo
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    // * dispatching AppStarted() event
    authenticationBloc.add(AppStarted());

    super.initState();
  }

  @override
  void dispose() {
    // * disposing authBloc
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication',
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (context, state) {
            Logger().d('state: $state');

            // * so that as long as the state is 'AuthenticationUninitialized'
            // * the splashScreen will remain visible
            if (state is! AuthenticationUninitialized) {
              FlutterNativeSplash.remove();
            }

            if (state is AuthenticationUnauthenticated) {
              return const AuthScreen();
            }

            if (state is AuthenticationAuthenticated) {
              return const HomeScreen();
            }

            if (state is AuthenticationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text('AuthticationState Error'));
          },
        ),
      ),
    );
  }
}
