import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api.dart' as api;
import 'newlist.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textController = TextEditingController();

Future<void> _saveTaskAndRefresh(BuildContext context) async {
  final todoProvider = Provider.of<NewList>(context, listen: false);

  api.ToDo newTask = api.ToDo(
    title: _textController.text,
    done: false,
  );

  const String apiKey = '25df0750-6829-47ac-be32-0de39a38b327';
  await context.read<api.Api>().addToDo(newTask, apiKey);

  try {
    await todoProvider.fetchAndSetTodos(apiKey);
  } catch (e) {
    print('Failed to fetch and set todos: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Container(
          alignment: Alignment.center,
          child: Image.asset(
            "C://Users/elisa/gusluelo/android/images/todolist.png",
            width: 35,
            height: 35,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter Task Name'),
              onChanged: (text) {},
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<NewList>(
                builder: (context, todoProvider, child) {
                  List<api.ToDo> savedTasks = todoProvider.apiTodos;
                  return FloatingActionButton.extended(
                    onPressed: () async {
                    print('save button pressed');
                    final newTodo = api.ToDo(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _textController.text,
                      done: false,
                    );
                    const String apiKey = '25df0750-6829-47ac-be32-0de39a38b327';
                    await context.read<api.Api>().addToDo(newTodo, apiKey);
                    await Provider.of<NewList>(context, listen: false).fetchAndSetTodos(apiKey);

                    Navigator.pop(context);
                  },
                    label: Text('Save Task'),
                    backgroundColor: Colors.black,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
