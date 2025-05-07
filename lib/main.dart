import 'package:flutter/material.dart';
import 'package:todo_app/Post.dart';
import 'package:todo_app/homepage.dart';
import 'package:todo_app/postview.dart';
import 'approutes.dart';
// import 'package:todoapplication/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Postpage(),
      routes: {
        Approutes.postScreen: (ctx) => Postpage(),
        Approutes.postviewScreen: (ctx) => Postview(),
      },
      // hello..
    );
  }
}