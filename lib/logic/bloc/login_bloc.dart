import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
  }) : super(LoginInitial());

  // @override
  LoginState get initialState => LoginInitial();

  // @override
  Stream<LoginState> mapEventToState(currentState, event) async* {
    // for logging in
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final response = await userRepository.authenticate(
          signinData: event.loginData,
        );

        // dispatch event
        authenticationBloc.add(
          LoggedIn(token: response['token']),
        );

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    // for registering
    if (event is RegisterButtonPressed) {}
  }
}
