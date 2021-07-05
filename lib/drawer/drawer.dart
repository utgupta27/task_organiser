import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_organiser/homePage/homePage.dart';
import 'package:task_organiser/main.dart';
import 'package:task_organiser/res/customColors.dart';
// import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  static var data;
  MyDrawer() {
    data = HomePageState.data;
  }
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  // static bool switchValue = false;
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
          // UserAccountsDrawerHeader(
          //   accountName: Text(
          //     "Task Organiser",
          //     style: TextStyle(fontSize: 21),
          //   ),
          //   accountEmail: Text(
          //       "Organise and keep track of your day-to\n-day Tasks and Notes."),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: AssetImage('assets/icon/task_organiser.png'),
          //   ),
          //   decoration: BoxDecoration(color: Colors.blue[800]),
          // ),
          UserAccountsDrawerHeader(
            accountName: Text(
              MyDrawer.data[1],
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            accountEmail: Text(
              MyDrawer.data[2],
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(MyDrawer.data[3]),
            ),
            decoration: BoxDecoration(color: CustomColors.firebaseNavy),
          ),
          // Container(
          //   height: 80,
          //   width: 80,
          //   child: Image.network(MyDrawer.data[3]),
          // ),
          // ListTile(
          //   leading: Icon(Icons.person, size: 30),
          //   title: Text(
          //     MyDrawer.data[1],
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   subtitle: Text("User Name"),
          //   // trailing: Icon(Icons.edit),
          // ),
          // ListTile(
          //   leading: Icon(Icons.dark_mode, size: 30),
          //   title: Text(
          //     "Dark Mode",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   subtitle: Text("Click to Toggle Dark Mode"),
          //   trailing: CupertinoSwitch(
          //     activeColor: CustomColors.firebaseNavy,
          //     value: TodoAndNotesApp.switchValue,
          //     onChanged: (value) {
          //       setState(() {
          //         super.setState(() {});
          //       });
          //       TodoAndNotesApp.switchValue = value;
          //       setState(() {
          //         super.setState(() {});
          //       });
          //     },
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.verified_rounded, size: 30),
            title: Text(
              "Version",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text("2.1 Stable"),
            // trailing: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
