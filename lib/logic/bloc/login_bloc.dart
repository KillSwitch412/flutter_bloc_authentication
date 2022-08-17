import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/user_repository.dart';
import 'authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      // ! logger
      Logger().d('Sending Login POST with ---> ${event.loginData}');

      final response = await userRepository.authenticate(
        loginData: event.loginData,
      );

      // ! logger
      Logger().d('responce ---> ${response.data}');
      Logger().d("responce ---> ${response.data['token']}");

      // * dispatch event
      authenticationBloc.add(
        LoggedIn(token: response.data['token']),
      );

      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      // ! logger
      Logger().d('Sending Login POST with ---> ${event.registerData}');

      final response = await userRepository.registerAndAuthenticate(
        registerData: event.registerData,
      );

      // ! logger
      Logger().d('responce ---> ${response.data}');
      Logger().d("responce ---> ${response.data['token']}");

      // * dispatch event
      authenticationBloc.add(
        LoggedIn(token: response.data['token']),
      );

      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  LoginState get initialState => LoginInitial();
}
