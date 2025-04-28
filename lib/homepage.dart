import 'package:flutter/material.dart';
import 'package:todoapplication/model/todo.dart';

class TodoApplication extends StatefulWidget {
   TodoApplication({super.key});

  List<Todo> todos = [
    Todo(id: "1",
    title: "This is title",
    description: "Mamaghar janxu",
    isCompleted: true,
    ),
     Todo(id: "2",
    title: "This is title",
    description: "Mamaghar janxu",
    isCompleted: true,
    ),
     Todo(id: "3",
    title: "This is title",
    description: "Mamaghar janxu",
    isCompleted: true,
    ),
     Todo(id: "4",
    title: "This is title",
    description: "Mamaghar janxu",
    isCompleted: true,
    ),
  ];

  @override
  State<TodoApplication> createState() => _TodoApplicationState();
}

class _TodoApplicationState extends State<TodoApplication> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Todo Application",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      
    );
  }
}