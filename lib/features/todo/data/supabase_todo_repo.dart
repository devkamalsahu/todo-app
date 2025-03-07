import 'package:supabase_flutter/supabase_flutter.dart';

import '/features/todo/domain/entity/todo.dart';
import '/features/todo/domain/repository/todo_repo.dart';

class SupabaseTodoRepo implements TodoRepo {
  final _database = Supabase.instance.client;
  final auth = Supabase.instance.client.auth;

  // Add Todo
  @override
  Future<void> addTodo(Todo todo) async {
    try {
      await _database.from('todos').insert(todo.toJson());
    } on PostgrestException catch (error) {
      throw Exception('Error adding Todos: ${error.message}');
    }
  }

  // update edit
  @override
  Future<void> editTodo(Todo todo) async {
    try {
      await _database.from('todos').update(todo.toJson()).eq('id', todo.id);
    } on PostgrestException catch (error) {
      throw Exception('Error editing todo: ${error.message}');
    }
  }

  // fetch all todos
  @override
  Future<List<Todo>> fetchAllTodo() async {
    try {
      final todoData = await _database
          .from('todos')
          .select()
          .eq('user_id', auth.currentUser!.id)
          .order('created_at', ascending: false);

      final todos = todoData.map((e) => Todo.fromJson(e)).toList();

      return todos;
    } on PostgrestException catch (error) {
      throw Exception('Error fetching todos: ${error.message}');
    }
  }

  // delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    try {
      await _database.from('todos').delete().eq('id', todo.id);
    } on PostgrestException catch (e) {
      throw Exception(e);
    }
  }
}
