// ignore_for_file: file_names

import 'dart:convert';

class Todo {
  String? description;
  // String ?currentTime;

  Todo(this.description);
  // Todo(this.description, this.currentTime);

  Todo.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    // currentTime = json["date-time"];
  }

  static Map<String, dynamic> toJson(Todo todo) =>
      {'description': todo.description};
  // {'description': todo.description, "date-time": todo.currentTime};

  static String encode(List<Todo> todos) => json.encode(
        todos.map<Map<String, dynamic>>((todo) => Todo.toJson(todo)).toList(),
      );

  static List<Todo> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<Todo>((item) => Todo.fromJson(item))
          .toList();
}
