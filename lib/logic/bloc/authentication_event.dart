part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([props = const []]) : super();
}

abstract class AppStarted extends AuthenticationEvent {}

abstract class LoggedIn extends AuthenticationEvent {
  final String token;
  const LoggedIn({required this.token});
}

abstract class LoggedOut extends AuthenticationEvent {}
