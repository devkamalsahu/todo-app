import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Todo {
  final String id;
  final String title;
  bool isCompleted;
  final String userId;

  // constructor
  Todo({
    String? id,
    required this.userId,
    required this.title,
    required this.isCompleted,
  }) : id = id ?? uuid.v1();

  // convert Todo -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_completed': isCompleted,
      'user_id': userId,
    };
  }

  // convert json -> Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
      userId: json['user_id'],
    );
  }
}
