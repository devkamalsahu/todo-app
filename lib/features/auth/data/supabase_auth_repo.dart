import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/domain/entity/user_profile.dart';
import 'package:todo_app/features/auth/domain/repository/auth_repo.dart';

class SupabaseAuthRepo implements AuthRepo {
  final auth = Supabase.instance.client.auth;
  final db = Supabase.instance.client;

  @override
  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  @override
  Future<User?> loginWithEmailPassword({
    required email,
    required String password,
  }) async {
    try {
      final response = await auth.signInWithPassword(
        password: password,
        email: email,
      );

      return response.user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<User?> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // signup request
      final response = await auth.signUp(email: email, password: password);
      final user = response.user;
      if (user != null) {
        UserProfile userProfile = UserProfile(
          email: email,
          name: name,
          userId: user.id,
        );

        // storing user information
        await db.from('users').insert(userProfile.toJson());
      }

      return user;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }
}
