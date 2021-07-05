import 'package:flutter/material.dart';
import 'package:task_organiser/authHandler/authenticationHandler.dart';
import 'package:task_organiser/navigationBar/bottomNavigationBar.dart';
import 'package:task_organiser/res/customColors.dart';
import 'package:task_organiser/signin/signInScreen.dart';
import 'package:task_organiser/todoPage/todoPage.dart';
import 'package:task_organiser/notesPage/notesPage.dart';
import 'package:task_organiser/reminderPage/reminderPage.dart';
import 'package:task_organiser/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_organiser/widgets/appBarTitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late User _user;
  bool _isSigningOut = false;
  static var data;

  @override
  void initState() {
    _user = widget._user;
    setdata(_user.uid, _user.displayName, _user.email, _user.photoURL);
    super.initState();
  }

  setdata(uid, name, email, picUrl) {
    data = [uid, name, email, picUrl];
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
        title: AppBarTitle(),
        backgroundColor: CustomColors.firebaseNavy,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await Authentication.signOut(context: context);
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(_routeToSignInScreen());
              },
              icon: Icon(Icons.logout))
        ],
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
              title: Text(
                "  To-Do Lists",
                style: TextStyle(fontSize: 20),
              )),
          BottomNavyBarItem(
              icon: Icon(
                Icons.note_alt_outlined,
                size: 30,
              ),
              title: Text("  My Notes", style: TextStyle(fontSize: 20))),
          // BottomNavyBarItem(
          //     icon: Icon(
          //       Icons.alarm_on_outlined,
          //       size: 30,
          //     ),
          //     title: Text("Reminders"))
        ],
        selectedIndex: _currentIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}
