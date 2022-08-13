import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated());

  // @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  Stream<AuthenticationState> mapEventToState(currentState, event) async* {
    // at app startup
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    // at signin or register
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistData(event.token);
      yield AuthenticationAuthenticated();
    }

    // at logout
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteData();
      yield AuthenticationUnauthenticated();
    }
  }
}
