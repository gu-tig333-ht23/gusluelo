import 'package:flutter/material.dart';

class toDo {
  final String? id;
  final String title;
  bool done;

  toDo({
    required this.id,
    required this.title,
    this.done = false,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }
}


class TodoList extends ChangeNotifier {
// Create a private list of Todo objects to store the todos. 
  List<toDo> _todos = [];

// Define a getter to provide access to the list of todos.
  List<toDo> get todos => _todos;

    void setTodos(List<toDo> todos) {
    _todos = todos;
    notifyListeners();
  }

 // Method to add a new Todo to the list.
  void addTodo(toDo todo) {
// Add the provided todo to the list.
    _todos.add(todo);
//notify listerners that the title has changed
    notifyListeners();
  }

// Method to toggle the status of a Todo at a specific index.
  void todoStatus(int index) {
// Retrieve the Todo at the specified index.
    toDo todo = _todos[index];
// Update the Todo by creating a new Todo object with the same title but
  // the opposite status (toggled).
    _todos[index] = toDo(
      id: todo.id,
      title: todo.title,
      done: !todo.done,
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
