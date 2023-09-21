import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/todolist.dart' as td;

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String key = '25df0750-6829-47ac-be32-0de39a38b327';

class ToDo{
  final String title;
  final  String? id;
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

Future<List<ToDo>> gettodos() async {
  http.Response response = await http.get(Uri.parse('$ENDPOINT/todos'));
  String body = response.body;
  Map<String, dynamic> jsonResponse = jsonDecode(body);
  List todosjson = jsonResponse['Todos'];
  return todosjson.map((json) => ToDo.fromJson(json)).toList();
}

Future<void> addToDo (ToDo todo) async {
try {
    // Call the API to add a new to-do item
    http.Response response = await http.post(
      Uri.parse('$ENDPOINT/todos'),
      body: jsonEncode(todo.toJson()),
    );
    print(response.body);
    } catch (e) {
    print('Failed to add todo: $e');
}
}

