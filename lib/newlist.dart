import './api.dart' as api;
import 'package:flutter/material.dart';

class NewList extends ChangeNotifier {
  List<api.ToDo> _apiTodos = [];

  List<api.ToDo> get apiTodos => _apiTodos;

  Future<void> fetchAndSetTodos(String apiKey) async {
    try {
      _apiTodos = await api.Api().gettodos(apiKey);
      List<api.ToDo> convertedTodos = _apiTodos.map((todo) {
        return api.ToDo(
          title: todo.title,
          id: todo.id,
          done: todo.done,
        );
      }).toList();
      notifyListeners();
      setTodos(convertedTodos);
      print('Fetched Todos: $convertedTodos'); 
    } catch (e) {
      print('Failed to fetch todos: $e');
    }
  }

  void setTodos(List<api.ToDo> todo) {
    _apiTodos = todo;
    notifyListeners();
  }

  void addApiTodo(api.ToDo todo) {
    _apiTodos.add(todo);
    notifyListeners();
  }

 Future removeApiTodoById(String id, String apiKey) async {
  try {
    List<String> todoIds = _apiTodos.map((todo) => todo.id).toList().cast<String>();
    print('Todo IDs: $todoIds');

    if (todoIds.contains(id)) {
      int indexToRemove = _apiTodos.indexWhere((todo) => todo.id == id);

      if (indexToRemove >= 0 && indexToRemove < _apiTodos.length) {
        await api.Api().deleteToDo(id, apiKey);

        _apiTodos.removeAt(indexToRemove);
        notifyListeners();
        print('Todo deleted successfully.');
      } else {
        print('Invalid todo index: $indexToRemove');
      }
    } else {
      print('Todo with id $id does not exist.');
    }
  } catch (e) {
    print('Failed to delete todo: $e');
  }
}


  void todoStatus(int index) {
    _apiTodos[index].done = !_apiTodos[index].done;
    notifyListeners();
  }

  Future<void> updateApiTodo(api.ToDo todo, String apiKey) async {
    try {
      await api.Api().updateToDo(todo, apiKey);
      int indexToUpdate = _apiTodos.indexWhere((element) => element.id == todo.id);
      if (indexToUpdate >= 0 && indexToUpdate < _apiTodos.length) {
        _apiTodos[indexToUpdate] = todo;
        notifyListeners();
      } else {
        print('Invalid todo id: ${todo.id}');
      }
    } catch (e) {
      print('Failed to update todo: $e');
    }
  }

  Future<void> updateTaskStatus(api.ToDo task, bool newStatus, String apiKey) async {
  task.done = newStatus;
  try {
    await api.Api().updateToDo(task, apiKey);
  } catch (e) {
    print('Failed to update task status: $e');
  }
}
}



void main() async {
  final newList = NewList();
  final apiKey = api.Api.getApiKey();
  await newList.fetchAndSetTodos(apiKey);
  print('Fetched Todos: ${newList.apiTodos}');
}
