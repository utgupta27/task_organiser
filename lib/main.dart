import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_organiser/signin/signInScreen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    TodoAndNotesApp(),
  );
}

class TodoAndNotesApp extends StatefulWidget {
  const TodoAndNotesApp({Key? key}) : super(key: key);

  @override
  TodoAndNotesAppState createState() => TodoAndNotesAppState();
}

class TodoAndNotesAppState extends State<TodoAndNotesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do & Notes App",
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
