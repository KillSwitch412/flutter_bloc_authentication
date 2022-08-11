import 'package:flutter/material.dart';

enum AuthMode { register, signin }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode authMode = AuthMode.signin;
  // final _emailController = TextControlle;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register / Signin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                authMode == AuthMode.register ? 'Register' : 'Sign In',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              authMode == AuthMode.register
                  ? Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Password Confirm'),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('First Name'),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Last Name'),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('User Type'),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Gender'),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Age'),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  authMode == AuthMode.register ? 'Register' : 'Sign In',
                ),
              ),
              TextButton(
                onPressed: () {
                  if (authMode == AuthMode.register) {
                    setState(() {
                      authMode = AuthMode.signin;
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
    );
  }
}
