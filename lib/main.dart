import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/todo/data/supabase_todo_repo.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/utils/api/credential.dart';

import '/features/todo/presentation/pages/todo_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (context) => TodoCubit(todoRepo: supabaseTodoRepo),
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
        home: TodoPage(),
      ),
    );
  }
}
