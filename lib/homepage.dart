import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'To do list'),
      theme: new ThemeData(
        scaffoldBackgroundColor: Color(0xE5FAFAF3)
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
  bool _checkbox = false;
   @override
//appbar
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container (
          alignment: Alignment.center, 
          child: Image.asset
       ("C://Users/elisa/gusluelo/android/images/todolist.png", 
        width: 35, 
        height: 35, 
      )
      ),
//title
   title:  
     Padding  (
        padding: EdgeInsets.symmetric 
        (horizontal: 400), 
        child: Text(
          widget.title, 
          style: TextStyle(color: Color(0xFFFFFFFF), 
          fontSize: 25, 
          fontWeight: FontWeight.w500, 
          ),
          ),      
      ),
    ),  
//checkbox 1
      body: Center( 
      child:
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: _checkbox,
                  activeColor: Colors.black,             
                  onChanged: (value) {
                    setState(() {
                      _checkbox = !_checkbox;
                    });
                  },
                ),
                Text(
                 'something',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 17),
                  ),
              ],
            ),
          ],
        ),
      ),
//button
      floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: Colors.black,
                icon: Icon( 
                Icons.add,
                  size: 24.0,
                ),
                label: Text('New Task'), 
              ),
    )
   );
  }
}