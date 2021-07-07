import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_organiser/homePage/homePage.dart';
import 'package:task_organiser/res/customColors.dart';

class MyDrawer extends StatefulWidget {
  static var data;
  MyDrawer() {
    data = HomePageState.data;
  }
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
