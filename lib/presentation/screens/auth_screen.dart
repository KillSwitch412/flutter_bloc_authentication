import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/user_repository.dart';
import '../../logic/bloc/authentication_bloc.dart';
import '../../logic/bloc/login_bloc.dart';

enum AuthMode { register, login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, required this.userRepository}) : super(key: key);

  final UserRepository userRepository;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // * formkey
  final _formKey = GlobalKey<FormState>();
  // * authmode initially set to login
  AuthMode authMode = AuthMode.login;

  // * loginBloc
  late LoginBloc _loginBloc;
  // * authBloc --> get using blocProvider
  late AuthenticationBloc _authenticationBloc;

  // * getter for userRepo
  UserRepository get userRepository => widget.userRepository;

  // * register and login data is stored in these objects
  final registerData = {};
  final loginData = {};

  @override
  void initState() {
    // * getting from context
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    // * initializing --> not provinding globally bcz this is the only
    // * place where we need it
    _loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: _authenticationBloc,
    );

    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  // * functions
  Future<void> register() async {
    _formKey.currentState!.save();
    // print('----------> Register <----------');
    // print(registerData);
  }

  Future<void> login() async {
    // * closing keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    _formKey.currentState!.save();

    // ! logger
    Logger().d('login initiated with data ---> $loginData');

    _loginBloc.add(LoginButtonPressed(loginData: loginData));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Register / Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: _loginBloc,
              builder: (context, state) {
                // ! logger
                Logger().d('login state: $state');

                if (state is LoginFailure) {
                  // * using _onWidgetDidBuild:
                  // * so that SnackBar is only displayed after the builder
                  // * finishes building the widget.
                  // * Showing Snackbar during building gives and error
                  _onWidgetDidBuild(
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error Occured'),
                          backgroundColor: Colors.blue,
                        ),
                      );

                      return () {};
                    },
                  );
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        authMode == AuthMode.register ? 'Register' : 'Log In',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          registerData['email'] = value!;
                          loginData['email'] = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          registerData['password'] = value!;
                          loginData['password'] = value;
                        },
                        decoration: const InputDecoration(
                          label: Text('Password'),
                        ),
                      ),
                      authMode == AuthMode.register
                          ? Column(
                              children: [
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['passwordConfirm'] = value!;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('Password Confirm'),
                                  ),
                                ),
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['firstName'] = value!;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('First Name'),
                                  ),
                                ),
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['lastName'] = value!;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('Last Name'),
                                  ),
                                ),
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['userType'] = value!;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('User Type'),
                                  ),
                                ),
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['gender'] = value!;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('Gender'),
                                  ),
                                ),
                                TextFormField(
                                  onSaved: (value) {
                                    registerData['age'] = value!;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text('Age'),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Container(
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : null,
                      ),
                      ElevatedButton(
                        onPressed: state is! LoginLoading
                            ? () {
                                if (authMode == AuthMode.register) {
                                  register();
                                } else {
                                  login();
                                }
                              }
                            : null,
                        child: Text(
                          authMode == AuthMode.register ? 'Register' : 'Log In',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (authMode == AuthMode.register) {
                            setState(() {
                              authMode = AuthMode.login;
                            });
                          } else {
                            setState(() {
                              authMode = AuthMode.register;
                            });
                          }
                        },
                        child: const Text('Change auth mode'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onWidgetDidBuild(Function Function() callback) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      callback();
    });
  }
}
