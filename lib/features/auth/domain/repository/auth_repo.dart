/*

  Auth Repository: Outline the possible operations for this app.

*/

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<User?> loginWithEmailPassword({
    required email,
    required String password,
  });
  Future<User?> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();
}
