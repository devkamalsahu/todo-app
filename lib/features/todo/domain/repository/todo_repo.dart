import 'package:todo_app/features/todo/domain/entity/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> fetchAllTodo();
  Future<void> addTodo(Todo todo);
  Future<void> editTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}
