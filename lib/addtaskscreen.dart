import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todolist.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textController = TextEditingController();

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
      Align(alignment: Alignment.bottomCenter, 
      child: FloatingActionButton.extended(
        onPressed: () {
          final newTodo = Todo(title: _textController.text);
          todoProvider.addTodo(newTodo);
           _textController.clear();
          // Handle saving the task and navigating back to the previous screen here
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