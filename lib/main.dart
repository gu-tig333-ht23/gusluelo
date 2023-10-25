import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/addtaskscreen.dart';
import 'package:template/newlist.dart';
import './api.dart' as api;
import 'filtering.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewList(),
        ),
        Provider<api.Api>.value(
          value: api.Api(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Rebuilding widget');
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xE5FAFAF3)
        ),
        home: MyHomePage(title: 'To do list'),
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

  void _fetchAndSetTodos() async {
  final apiKey = api.Api.getApiKey();
  await Provider.of<NewList>(context, listen: false).fetchAndSetTodos(apiKey);
}

    @override
  void initState() {
    super.initState();
    _fetchAndSetTodos();
  }

  Widget _buildTaskList() {
    NewList todoProvider = Provider.of<NewList>(context, listen: false);
  List<api.ToDo> filteredTodos = applyFilter(todoProvider.apiTodos, _currentFilter);
final apiKey = api.Api.getApiKey();
  return ListView.builder(
    itemCount: filteredTodos.length,
    itemBuilder: (context, index) {
      print('Building item $index');
      final todo = filteredTodos[index];
      bool isDone = todo.done;
      return ListTile(
        title: Text(todo.title),
        leading: Checkbox(
          activeColor: Colors.black,
          value: isDone,
          onChanged: (newValue) {
            int originalIndex = todoProvider.apiTodos.indexOf(todo);
            todoProvider.todoStatus(originalIndex);
    todoProvider.updateTaskStatus(todo, newValue ?? false, apiKey);
    setState(() {
              todo.done = newValue ?? false;
            });
          },
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: 20.0,
            color: Colors.brown[900],
          ),
          onPressed: () async {
          await todoProvider.removeApiTodoById(todo.id!, apiKey);
          await todoProvider.fetchAndSetTodos(apiKey); 
},

        ),
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
body: Stack( children: [
    Consumer<NewList>(
            builder: (context, todoProvider, child) {
              return _buildTaskList();
            },
          ),
    Container( 
  margin: EdgeInsets.only(bottom: 16),
  child: Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            print('navigate button is pressed');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          label: Text('Create New Task'),
          backgroundColor: Colors.black,
        ),
      ],
    ),
  ),
),
  ],
      ),
    );
  }
}
