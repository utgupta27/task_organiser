import 'package:flutter/material.dart';
import 'package:task_organiser/bottomNavigationBar.dart';
import 'package:task_organiser/todoPage.dart';
import 'package:task_organiser/notesPage.dart';
import 'package:task_organiser/reminderPage.dart';
import 'package:task_organiser/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [TodoPage(), NotesPage(), ReminderPage()];

  void onItemTapped(int val) {
    setState(() {
      _currentIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Organiser"),
        backgroundColor: Colors.blue[800],
      ),
      drawer: MyDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: new BottomNavyBar(
        items: [
          BottomNavyBarItem(
              icon: Icon(
                Icons.task_alt,
                size: 30,
              ),
              title: Text("To-Do")),
          BottomNavyBarItem(
              icon: Icon(
                Icons.note_alt_outlined,
                size: 30,
              ),
              title: Text("Notes")),
          BottomNavyBarItem(
              icon: Icon(
                Icons.alarm_on_outlined,
                size: 30,
              ),
              title: Text("Reminders"))
        ],
        selectedIndex: _currentIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}
