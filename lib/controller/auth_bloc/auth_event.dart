
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckActiveUser extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignUp extends AuthEvent {
  final MindGlowUser usermodel;
  SignUp({required this.usermodel});
}

class Logoutevent extends AuthEvent {}

