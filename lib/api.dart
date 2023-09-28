import 'dart:convert';
import 'package:http/http.dart' as http;

class ToDo {
  final String title;
  final String? id;
  bool done;

  ToDo({
    required this.title,
    this.id,
    required this.done,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      title: json['title'],
      id: json['id'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'done': done,
    };
  }
}

class Api {
  static const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

  Future<List<ToDo>> gettodos(String apiKey) async {
    try {
      Uri urlWithKey = Uri.parse('$ENDPOINT/todos?key=$apiKey');

      http.Response response = await http.get(urlWithKey);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<ToDo> todosList =
            jsonResponse.map((json) => ToDo.fromJson(json)).toList();
        return todosList;
      } else {
        throw Exception('Failed to get todos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

  Future<void> addToDo(ToDo todo, String apiKey) async {
    try {
      final url = Uri.parse('$ENDPOINT/todos?key=$apiKey');

      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        print('Todo added successfully.');
      } else {
        throw Exception('Failed to add todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<void> deleteToDo(String todoId, String apiKey) async {
    try {
      final url = Uri.parse('$ENDPOINT/todos/$todoId?key=$apiKey');

      http.Response response = await http.delete(
        url,
      );

      if (response.statusCode == 200) {
        print('Todo deleted successfully.');
      } else {
        throw Exception('Failed to delete todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  Future<void> updateToDo(ToDo todo, String apiKey) async {
  try {
    final url = Uri.parse('$ENDPOINT/todos/${todo.id}?key=$apiKey');

    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      print('Todo updated successfully.');
    } else {
      throw Exception('Failed to update todo: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to update todo: $e');
  }
}
}


