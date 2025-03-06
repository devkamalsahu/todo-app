import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/auth/data/supabase_auth_repo.dart';
import '/features/auth/presentation/cubit/auth_cubit.dart';
import '/features/auth/presentation/cubit/auth_states.dart';
import '/features/todo/presentation/pages/todo_page.dart';
import '/features/auth/presentation/pages/auth_screen.dart';
import '/features/todo/data/supabase_todo_repo.dart';
import '/features/todo/presentation/cubit/todo_cubit.dart';
import '/utils/api/credential.dart';
import '/utils/theme/elevated_button.dart';
import '/utils/theme/input_decoration_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(url: url, anonKey: anonKey);
  } catch (e) {
    print('Initialization error: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final supabaseTodoRepo = SupabaseTodoRepo();
  final supabaseAuthRepo = SupabaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (context) {
            return TodoCubit(todoRepo: supabaseTodoRepo);
          },
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: supabaseAuthRepo),
        ),
      ],
      child: MaterialApp(
        title: 'TODO App',
        theme: ThemeData(
          elevatedButtonTheme: elevatedButtonTheme,
          inputDecorationTheme: inputDecorationTheme,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, authState) {
            final authcubit = context.read<AuthCubit>();
            authcubit.checkAuth();

            if (authState is UnAuthenticated) {
              return AuthScreen();
            }
            if (authState is Authenticated) {
              return TodoPage();
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
