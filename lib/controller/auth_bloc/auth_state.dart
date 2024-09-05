part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String user;

  Authenticated(this.user);
}

class AuthenticateError extends AuthState {
  final String message;
  AuthenticateError(this.message);
}

class UnAuthenticated extends AuthState {}
