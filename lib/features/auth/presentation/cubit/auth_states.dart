import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthStates {}

// initial
class AuthInitial extends AuthStates {}

// loading
class AuthLoading extends AuthStates {}

// authenticated
class Authenticated extends AuthStates {
  User user;

  Authenticated(this.user);
}

// unauthenticated
class UnAuthenticated extends AuthStates {}

// auth error
class AuthError extends AuthStates {
  final String message;

  AuthError(this.message);
}
