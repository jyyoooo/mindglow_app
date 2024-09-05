import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindglowequinox/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    // all authentication events and handlers
    on<CheckActiveUser>(_onCheckActiveUser);
    on<SignUp>(_onSignUp);
    on<Logoutevent>(_onLogout);
    on<LoginEvent>(_onLogin);
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCreds = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final User? user = userCreds.user;
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthenticateError(e.toString()));
    }
  }

  FutureOr<void> _onLogout(Logoutevent event, Emitter<AuthState> emit) async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthenticateError(e.toString()));
    }
  }

  FutureOr<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCreds = await _auth.createUserWithEmailAndPassword(
        email: event.usermodel.email.toString(),
        password: event.usermodel.password.toString(),
      );
      final User? user = userCreds.user;
      log('USER : ${user?.email}');
      // if (user != null) {
      //   await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      //     'displayName': event.usermodel.name,
      //     'email': event.usermodel.email,
      //     'uid': user.uid,
      //     'phoneNumber': event.usermodel.phone,
      //     'cratedate': DateTime.now(),
      //   });
      // }
      emit(Authenticated(user!.uid));
    } catch (e) {
      emit(AuthenticateError(e.toString()));
    }
  }

  FutureOr<void> _onCheckActiveUser(
      CheckActiveUser event, Emitter<AuthState> emit) async {
    User? user;
    try {
      user = _auth.currentUser;
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthenticateError(e.toString()));
    }
  }
}
