import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.toggleAuth});
  final void Function() toggleAuth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers
  final emailConstroller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailConstroller.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void login() {
    final email = emailConstroller.text;
    final password = passwordController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            // Icon
            Icon(Icons.lock_open, color: Colors.black54, size: 170),

            SizedBox(height: 10),

            // text
            Center(
              child: Text(
                'Welcome back! You have been missed',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ),

            SizedBox(height: 10),

            // email
            TextFormField(
              controller: emailConstroller,
              decoration: InputDecoration(hintText: 'email'),
            ),

            SizedBox(height: 10),

            // password
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'password'),
            ),

            SizedBox(height: 10),

            // register
            ElevatedButton(onPressed: login, child: Text('Login')),

            SizedBox(height: 5),

            // toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.toggleAuth,
                  child: Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
