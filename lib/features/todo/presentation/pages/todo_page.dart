import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import '/features/todo/domain/entity/todo.dart';
import '/features/todo/presentation/cubit/todo_state.dart';

import '../cubit/todo_cubit.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final titleController = TextEditingController();

  late final todoCubit = context.read<TodoCubit>();
  late final authCubit = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();

    loadTodos();
  }

  void loadTodos() {
    todoCubit.fetchAllTodo();
  }

  // add todo
  void addTodo(bool isEditing, Todo? todo) {
    titleController.text = todo != null ? todo.title : '';
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Container(
              height: 400,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    isEditing ? 'Edit Todo' : 'Add Todo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'title'),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      onSubmit(isEditing, todo);
                    },
                    child: Text(isEditing ? 'Update' : 'Add'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void onSubmit(bool isEditing, Todo? todo) {
    if (isEditing) {
      final updatedTodo = Todo(
        userId: authCubit.getCurrentUser!.id,
        id: todo!.id,
        title: titleController.text.trim(),
        isCompleted: todo.isCompleted,
      );
      todoCubit.updateTodo(updatedTodo);
    } else {
      // create a todo
      final todo = Todo(
        title: titleController.text,
        isCompleted: false,
        userId: authCubit.getCurrentUser!.id,
      );
      todoCubit.createTodo(todo);
    }
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T O D O'),
        actions: [
          IconButton(
            onPressed: () {
              final authCubit = context.read<AuthCubit>();
              authCubit.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading || state is TodoUploading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;

            if (todos.isEmpty) {
              return Center(child: Text('No Todo added'));
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = state.todos[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isCompleted,

                      onChanged: (value) {
                        todo.isCompleted = value!;

                        todoCubit.updateTodo(todo);
                      },
                    ),
                    title: Text(todos[index].title),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              addTodo(true, todo);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              todoCubit.deleteTodo(todo);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          } else {
            loadTodos();
            return SizedBox();
          }
        },

        listener: (context, state) {
          if (state is TodoUploaded) {
            Navigator.of(context).pop();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(false, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
