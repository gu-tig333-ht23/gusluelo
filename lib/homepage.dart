import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/addtaskscreen.dart';
import 'todolist.dart';
import './api.dart';

enum TaskFilter {
  all,
  active,
  notActive,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoList(),
    child: MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xE5FAFAF3)
        ),
        home: MyHomePage(title: 'To do list'),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
   TaskFilter _currentFilter = TaskFilter.all;

  void _setFilter(TaskFilter filter) {
    setState(() {
      _currentFilter = filter;
    });
  }
    Widget _buildTaskList() {
    final todoProvider = Provider.of<TodoList>(context);
    List<Todo> filteredTodos;

 // Apply the filter
    if (_currentFilter == TaskFilter.active) {
      filteredTodos = todoProvider.todos.where((todo) => todo.isDone).toList();
    } else if (_currentFilter == TaskFilter.notActive) {
      filteredTodos = todoProvider.todos.where((todo) => !todo.isDone).toList();
    } else {
      filteredTodos = todoProvider.todos;
    }

    return ListView.builder(
      itemCount: todoProvider.todos.length,
      itemBuilder: (context, index) {
        final todo = filteredTodos[index];
        return ListTile(
          title: Text(todo.title),
          leading: Checkbox(
            activeColor: Colors.black,
            value: todo.isDone,
            onChanged: (_) {
              int originalIndex = todoProvider.todos.indexOf(todo);
            todoProvider.todoStatus(originalIndex);
            },
          ),
//delete button
 trailing: 
              IconButton(icon: Icon(
                Icons.delete_outline,
                size: 20.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                int originalIndex = todoProvider.todos.indexOf(todo);
            todoProvider.deleteTodo(originalIndex);
              },
         )

        );
      },
    );
  }

   @override
//appbar
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.title,
        style: TextStyle ( 
          fontSize: 25, 
          fontWeight: FontWeight.w500,)), 
          actions: [
            IconButton(onPressed: () {
              showDialog(
                context: context, 
                builder: (context) {
                return SimpleDialog (
                  title: Text('Filter Tasks'),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        _setFilter(TaskFilter.all);
                        Navigator.pop(context);
                      },
                      child: Text('All tasks'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _setFilter(TaskFilter.notActive);
                        Navigator.pop(context);
                      },
                      child: Text('Tasks to do'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _setFilter(TaskFilter.active);
                        Navigator.pop(context);
                      },
                      child: Text('Tasks finished'),
                    ),
                  ],
                );
                });
            }, 
            icon: Icon(
              kIsWeb ? Icons.more_vert: Icons.more_horiz 
              ),
            ),
          ],
        leading: Container (
          alignment: Alignment.center, 
          child: Image.asset
       ("C://Users/elisa/gusluelo/android/images/todolist.png", 
        width: 35, 
        height: 35, 
      )
      ), 
    ),  
    
//new task button
body: Stack(
    children: [ 
      _buildTaskList(),
      Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child:
        Align (
        alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddTaskScreen())
                    );
                  },
                  label: Text('Create New Task'),
                backgroundColor: Colors.black,
           ),
           SizedBox(width: 16),
           FloatingActionButton.extended(
            onPressed: () {gettodos();
            }, 
            label: Text('Load API'),
            backgroundColor: Colors.black,
            )
              ]
         )
        )
      )],
      ),
    );
  }
}
