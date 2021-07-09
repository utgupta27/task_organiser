import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:task_organiser/homePage/homePage.dart';

import 'package:task_organiser/res/customColors.dart';
import 'package:task_organiser/todoPage/addNewTaskPage.dart';
import 'package:task_organiser/todoPage/viewTask.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  static var data = HomePageState.data;
  static final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  Color getColor(var color) {
    if (color == "High") {
      return Colors.red;
    } else if (color == "Low") {
      return Colors.yellow;
    } else
      return Colors.green;
  }

  getSubtitle(var data) {
    if (data.length < 60) {
      return data;
    } else if (data.length >= 60) {
      return data.substring(0, 58) + "...";
    }
  }

  onButtonPressed(id) async {
    final CollectionReference _userCollection = _firebase
        .collection(HomePageState.data[0])
        .doc('todos')
        .collection('items');
    DocumentReference _userDocs = _userCollection.doc(id.toString());
    _userDocs.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: TodoPage._firebase
              .collection(TodoPage.data[0])
              .doc('todos')
              .collection('items')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 110,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[100],
                            border: Border(
                                left: BorderSide(
                                    width: 7.0,
                                    color:
                                        getColor(document.data()['color'])))),
                        child: Column(
                          children: [
                            ListTile(
                              // leading: Icon(Icons.arrow_right_rounded),
                              onTap: () {
                                // Call A function
                                ViewTask.sendData(
                                    document.data()['docID'],
                                    document.data()['title'],
                                    document.data()['subtitle'],
                                    document.data()['color'],
                                    document.data()['dueDate'],
                                    document.data()['date']);

                                setState(() {
                                  super.setState(() {});
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => new ViewTask()),
                                );
                              },
                              minLeadingWidth: 5,
                              title: Text(
                                document.data()['title'],
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              subtitle: Text(
                                  getSubtitle(document.data()['subtitle'])),
                              trailing: Container(
                                child: ElevatedButton(
                                  child: Icon(Icons.done_outline_rounded),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () {
                                    onButtonPressed(document.data()['docID']);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Due: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(document.data()['dueDate'].microsecondsSinceEpoch))}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            super.setState(() {});
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => new AddNewTaskPage()),
          );
        },
        child: Icon(Icons.add_task_rounded),
        elevation: 10,
        backgroundColor: CustomColors.firebaseNavy,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
