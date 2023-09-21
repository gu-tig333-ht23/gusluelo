import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todolist.dart';
import 'api.dart' as api;
import 'data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textController = TextEditingController();

  Future<void> addTodo (toDo todo) async{
     try {
     final url = Uri.parse('${api.ENDPOINT}/todos?key=${api.key}');
     print('URL: $url');
     http.Response response = await http.post(
     url,
     body: jsonEncode(todo.toJson()),
     );
     // Call the API to add a new to-do item
     print(response.body);
     } catch (e) {
     print('Failed to add todo: $e');
     }
     }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Container (
          alignment: Alignment.center, 
          child: Image.asset
       ("C://Users/elisa/gusluelo/android/images/todolist.png", 
        width: 35, 
        height: 35, 
      )
      )
      ),
      body: Column( children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: TextField(
          controller: _textController, // Provide a controller for the TextField
          decoration: InputDecoration(labelText: 'Enter Task Name'),
          onChanged: (text) {
            // You can handle text changes here if needed

          },
        ),
      ),
      
      Positioned(
        bottom: 16,
        left: 0,
        right: 0,
      child:
     Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: () async {
                final newTodo = toDo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _textController.text,
                  done: false, // Assuming a new task is not done by default
                );
                await addTodo(newTodo);
                Navigator.pop(context);
            
              },
        label: Text('Save Task'),
        backgroundColor: Colors.black,
              ),
              )
              )
            ])
           );   
          // Handle saving the task and navigating back to the previous screen here
        }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}