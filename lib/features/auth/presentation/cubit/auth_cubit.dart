/*

  Auth cubit -> State management

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  User? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if user alredy exist
  void checkAuth() async {
    final user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(_currentUser!));
    } else {
      emit(UnAuthenticated());
    }
  }

  // get current user
  User? get getCurrentUser => _currentUser;

  // login with email + pw
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // register
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    authRepo.logout();
    emit(UnAuthenticated());
  }
}
