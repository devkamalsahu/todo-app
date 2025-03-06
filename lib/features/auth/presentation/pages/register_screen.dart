import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.toggleAuth});

  final void Function() toggleAuth;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controllers
  final emailConstroller = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  void dispose() {
    emailConstroller.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  void register() {
    final name = nameController.text;
    final email = emailConstroller.text;
    final password = passwordController.text;
    final confirmPw = confirmPwController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (password != confirmPw) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('passwrod didn\'t match.')));
      }
      // registration
      authCubit.register(name: name, email: email, password: password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the information.')),
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
            Icon(Icons.lock, color: Colors.black54, size: 170),

            SizedBox(height: 10),

            // text
            Center(
              child: Text(
                'Let\'s create an Account for you!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              ),
            ),

            SizedBox(height: 10),
            // name
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'name'),
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

            // confirm password
            TextFormField(
              obscureText: true,
              controller: confirmPwController,
              decoration: InputDecoration(hintText: 'confirm password'),
            ),

            SizedBox(height: 10),

            // register
            ElevatedButton(onPressed: register, child: Text('Register')),

            SizedBox(height: 5),

            // toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.toggleAuth,
                  child: Text(
                    'Login',
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
