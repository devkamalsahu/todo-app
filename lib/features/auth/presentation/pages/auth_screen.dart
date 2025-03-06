import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/presentation/pages/login_screen.dart';
import 'package:todo_app/features/auth/presentation/pages/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleAuth() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(toggleAuth: toggleAuth);
    } else {
      return RegisterScreen(toggleAuth: toggleAuth);
    }
  }
}
