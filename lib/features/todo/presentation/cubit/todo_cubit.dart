import 'package:todo_app/features/todo/domain/entity/todo.dart';
import 'package:todo_app/features/todo/domain/repository/todo_repo.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepo todoRepo;

  TodoCubit({required this.todoRepo}) : super(TodoInitial());

  // add a new todo
  Future<void> createTodo(Todo todo) async {
    try {
      emit(TodoUploading());
      await todoRepo.addTodo(todo);
      emit(TodoUploaded());
    } catch (e) {
      emit(TodoError('Failed to create Todo: $e'));
    }
  }

  // update todo
  Future<void> updateTodo(Todo todo) async {
    try {
      emit(TodoUpdating());
      await todoRepo.editTodo(todo);
      fetchAllTodo();
    } catch (e) {
      emit(TodoError('Failed to update todo: $e'));
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      emit(TodoDeleting());
      await todoRepo.deleteTodo(todo);
      fetchAllTodo();
    } catch (e) {
      emit(TodoError('Failed to delete todo: $e'));
    }
  }

  Future<void> fetchAllTodo() async {
    try {
      emit(TodoLoading());
      final todos = await todoRepo.fetchAllTodo();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError('Failed to fetch Todos: $e'));
    }
  }
}
