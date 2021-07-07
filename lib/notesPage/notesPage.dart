import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_organiser/homePage/homePage.dart';
import 'package:intl/intl.dart';
import 'package:task_organiser/notesPage/addNewNotesPage.dart';
import 'package:task_organiser/notesPage/viewNotes.dart';
import 'package:task_organiser/res/customColors.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);
  static var data = HomePageState.data;
  // NotesPage() {
  //   data = ;
  // }
  static final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Color? getColor(value) {
    if (value == "Pink") {
      return Colors.pink[200];
    } else if (value == "Purple") {
      return Colors.purple[200];
    } else if (value == "Blue") {
      return Colors.blue[200];
    } else if (value == "Cyan") {
      return Colors.cyan[200];
    } else if (value == "Teal") {
      return Colors.teal[200];
    } else if (value == "Yellow") {
      return Colors.yellow[500];
    } else if (value == "Orange") {
      return Colors.orange[200];
    } else if (value == "Brown") {
      return Colors.brown[200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: NotesPage._firebase
              .collection(NotesPage.data[0])
              .doc('notes')
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
                      child: InkWell(
                    child: new Container(
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600]!,
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                          ],
                          color: getColor(document.data()['color'].toString())),
                      // color: Colors.amber,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${document.data()['title'].toString()}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '${document.data()['subtitle'].toString()}',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                    "${DateFormat('dd/MM').format(DateTime.fromMicrosecondsSinceEpoch(document.data()['date'].microsecondsSinceEpoch))}")),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      ViewNotes.sendData(
                        document.data()['docID'],
                        document.data()['title'],
                        document.data()['subtitle'],
                        document.data()['color'],
                        document.data()['date'],
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => new ViewNotes()),
                      );
                    },
                  )),
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
            MaterialPageRoute(builder: (_) => new AddNewNotesPage()),
          );
        },
        backgroundColor: CustomColors.firebaseNavy,
        elevation: 10,
        child: Icon(
          Icons.note_add_outlined,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
