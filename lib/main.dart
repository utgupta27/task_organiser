import 'package:flutter/material.dart';
import 'package:task_organiser/homePage/homePage.dart';

void main(List<String> args) {
  runApp(TodoAndNotesApp());
}

class TodoAndNotesApp extends StatelessWidget {
  const TodoAndNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do & Notes App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
