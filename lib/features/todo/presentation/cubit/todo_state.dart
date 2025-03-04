import '../../domain/entity/todo.dart';

abstract class TodoState {}

// initial state
class TodoInitial extends TodoState {}

// uploaded
class TodoUploaded extends TodoState {}

// loading
class TodoLoading extends TodoState {}

// adding
class TodoUploading extends TodoState {}

// updating
class TodoUpdating extends TodoState {}

// deleting
class TodoDeleting extends TodoState {}

// error
class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}

// loaded
class TodoLoaded extends TodoState {
  List<Todo> todos;

  TodoLoaded(this.todos);
}
