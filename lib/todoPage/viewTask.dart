import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_organiser/homePage/homePage.dart';
import 'package:task_organiser/notesPage/viewNotes.dart';
import 'package:task_organiser/todoPage/editTodoPage.dart';
// import 'package:task_organiser/databaseHandler/databaseHandlerTodos.dart';
// import "package:task_organiser/todoPage/editTodoPage.dart";

final FirebaseFirestore _firebase = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firebase
    .collection(HomePageState.data[0])
    .doc('todos')
    .collection('items');

class ViewTask extends StatefulWidget {
  // const ViewTask({Key? key}) : super(key: key);
  static var id;
  static var title;
  static var subTitle;
  static var priority;
  static var dueDate;
  static var date;

  static sendData(aid, atitle, asubTitle, apriority, adueDate, adate) {
    id = aid;
    title = atitle;
    subTitle = asubTitle;
    priority = apriority;
    dueDate = adueDate;
    date = adate;
  }

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  onButtonPressed(id) async {
    DocumentReference _userDocs = _userCollection.doc(id.toString());
    _userDocs.delete();
  }

  Color getColor() {
    if (ViewTask.priority == "High") {
      return Colors.red;
    } else if (ViewTask.priority == "Low") {
      return Colors.yellow;
    } else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Your Task"),
        centerTitle: true,
        backgroundColor: getColor(),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                EditTodoPageState.sendData(
                    ViewTask.id,
                    ViewTask.title,
                    ViewTask.subTitle,
                    ViewTask.priority,
                    ViewTask.dueDate,
                    ViewTask.date);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => new EditTodoPage()),
                );
              },
              icon: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                onButtonPressed(ViewTask.id);
                setState(() {
                  super.setState(() {});
                });
                Navigator.pop(context, true);
                setState(() {
                  super.setState(() {});
                });
              },
              icon: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.task_alt,
                size: 40,
                color: getColor(),
              ),
              title: Text(
                "${ViewTask.title}",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: getColor()),
              ),
              subtitle: Text("Title"),
            ),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Details: ",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 20, 10),
                      child: Text(
                        ViewTask.subTitle,
                        style: TextStyle(fontSize: 22, color: Colors.grey[600]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.timer,
                      color: Colors.red,
                      size: 35,
                    ),
                    title: Text(
                      "${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(ViewTask.dueDate.microsecondsSinceEpoch))}",
                      style: TextStyle(fontSize: 23),
                    ),
                    subtitle: Text('Due Date'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.watch_later_outlined,
                      color: Colors.blue,
                      size: 35,
                    ),
                    title: Text(
                      "${DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(ViewTask.date.microsecondsSinceEpoch))}",
                      style: TextStyle(fontSize: 23),
                    ),
                    subtitle: Text('Time When Added'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.date_range_outlined,
                      color: Colors.blue,
                      size: 35,
                    ),
                    title: Text(
                      "${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(ViewTask.date.microsecondsSinceEpoch))}",
                      style: TextStyle(fontSize: 23),
                    ),
                    subtitle: Text('Date when Added'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
