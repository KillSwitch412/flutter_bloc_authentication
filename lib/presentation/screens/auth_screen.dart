import 'package:flutter/material.dart';

enum AuthMode { register, login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthMode authMode = AuthMode.login;

  // * register and login data is stored in these objects
  final registerData = {};
  final loginData = {};

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> register() async {
    _formKey.currentState!.save();
    // print('----------> Register <----------');
    // print(registerData);
  }

  Future<void> login() async {
    _formKey.currentState!.save();
    // print('----------> Log in <----------');
    // print(loginData);
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
            child: Form(
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
                  ElevatedButton(
                    onPressed: () {
                      if (authMode == AuthMode.register) {
                        register();
                      } else {
                        login();
                      }
                    },
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
            ),
          ),
        ),
      ),
    );
  }
}
