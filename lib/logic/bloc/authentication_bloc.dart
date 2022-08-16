import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await userRepository.persistData(event.token);
    emit(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await userRepository.deleteData();
    emit(AuthenticationUnauthenticated());
  }

  AuthenticationState get initialState => AuthenticationUninitialized();
}
