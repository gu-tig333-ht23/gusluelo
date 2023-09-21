import './api.dart' as api;
import 'package:flutter/material.dart';

class MyState extends ChangeNotifier {
  List<api.ToDo> _todos = [];

  List<api.ToDo> get todos => _todos;

  void fetchTodos() async {
    var todos = await api.gettodos();
    _todos = todos;
    notifyListeners();
  }
// Method to set todos and notify listeners
    void setTodos(List<api.ToDo> todos) {
    _todos = todos;
    notifyListeners();
  }

// Method to add a todo and notify listeners
  void addTodo(api.ToDo todo) {
    _todos.add(todo);
    notifyListeners();
}

// Method to remove a todo and notify listeners
  void removeTodoById(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
  
}