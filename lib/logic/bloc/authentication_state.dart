part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

// un-unitialized
class AuthenticationUninitialized extends AuthenticationState {}

// authenticated
class AuthenticationAuthenticated extends AuthenticationState {}

// un-authenticated
class AuthenticationUnauthenticated extends AuthenticationState {}

// loading
class AuthenticationLoading extends AuthenticationState {}
