import 'package:flutter/material.dart';

class Todo {
  final String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}

class TodoList extends ChangeNotifier {
// Create a private list of Todo objects to store the todos. 
  List<Todo> _todos = [];

// Define a getter to provide access to the list of todos.
  List<Todo> get todos => _todos;

 // Method to add a new Todo to the list.
  void addTodo(Todo todo) {
// Add the provided todo to the list.
    _todos.add(todo);
//notify listerners that the title has changed
    notifyListeners();
  }

// Method to toggle the status of a Todo at a specific index.
  void todoStatus(int index) {
// Retrieve the Todo at the specified index.
    Todo todo = _todos[index];
// Update the Todo by creating a new Todo object with the same title but
  // the opposite status (toggled).
    _todos[index] = Todo(
      title: todo.title,
      isDone: !todo.isDone,
      );
      notifyListeners();
  }

  // Method to delete a Todo at a specific index.
  void deleteTodo(int index) {
    // Remove the Todo at the specified index.
    _todos.removeAt(index);
    // Notify listeners that the list has changed.
    notifyListeners();
  }
}
