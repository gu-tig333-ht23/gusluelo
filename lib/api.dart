import 'dart:convert';
import 'package:http/http.dart' as http;

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

class todo {
  final String title;
  final  String? id;
  bool done;

  todo({
    required this.title,
    this.id,
    required this.done,
  });
}

Future<List<todo>> gettodos() async {
  print('Making request to API');
  http.Response response = await http.get(Uri.parse('$ENDPOINT/todo'));
  String body = response.body;
  print(body);
  Map<String, dynamic> jsonResponse = jsonDecode(body);
  List todosJson = jsonResponse['Todos'];
  print(todosJson.length);
  return[];
}
