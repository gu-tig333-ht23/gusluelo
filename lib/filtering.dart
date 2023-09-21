import 'todolist.dart';

enum TaskFilter {
  all,
  active,
  notActive,
}

List<toDo> applyFilter(List<toDo> todos, TaskFilter filter) {
  switch (filter) {
    case TaskFilter.active:
      return todos.where((todo) => todo.done).toList();
    case TaskFilter.notActive:
      return todos.where((todo) => !todo.done).toList();
    default:
      return todos;
  }
}