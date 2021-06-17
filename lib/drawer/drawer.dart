import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          //   child: Center(
          //     child: Text(
          //       "Developed By",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 40),
          //     ),
          //   ),
          //   decoration: BoxDecoration(color: Colors.blue[800]),
          // ),
          UserAccountsDrawerHeader(
            accountName: Text(
              "Task Organiser",
              style: TextStyle(fontSize: 35),
            ),
            accountEmail: Text(
                "Organise and keep track of your day-to\n-day Tasks and Notes."),
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: AssetImage('assets/profile.png'),
            // ),
            decoration: BoxDecoration(color: Colors.blue[800]),
          ),
          ListTile(
            leading: Icon(Icons.person, size: 30),
            title: Text(
              "Utsav Gupta",
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("github.com/utgupta27"),
            // trailing: Icon(Icons.edit),
          ),
          ListTile(
            leading: Icon(Icons.email, size: 30),
            title: Text(
              "Feedback Email",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text("utgupta27@gmail.com"),
            // trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(Icons.verified_rounded, size: 30),
            title: Text(
              "Version",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text("1.0 (Stable)"),
            // trailing: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
