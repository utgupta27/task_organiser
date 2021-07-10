import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_organiser/homePage/homePage.dart';
import 'package:task_organiser/notesPage/editNotesPage.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({Key? key}) : super(key: key);
  static var id;
  static var title;
  static var subTitle;
  static var color;
  static var date;

  static sendData(aid, atitle, asubTitle, acolor, adate) {
    id = aid;
    title = atitle;
    subTitle = asubTitle;
    color = acolor;
    date = adate;
  }

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
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

  onButtonPressed(id) async {
    final CollectionReference _userCollection = _firebase
        .collection(HomePageState.data[0])
        .doc('notes')
        .collection('items');
    print(id);
    DocumentReference _userDocs = _userCollection.doc(id.toString());
    _userDocs.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: Text(
            "${ViewNotes.title}",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: getColor(ViewNotes.color),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                EditNotesPageState.sendData(ViewNotes.id, ViewNotes.title,
                    ViewNotes.subTitle, ViewNotes.color, ViewNotes.date);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => new EditNotesPage()),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                onButtonPressed(ViewNotes.id);
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
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: Container(
        color: getColor(ViewNotes.color),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  // color: getColor(ViewNotes.color),
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "${ViewNotes.subTitle}",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )),
            ),
            Text(
                "${DateFormat('dd/MM').format(DateTime.fromMicrosecondsSinceEpoch(ViewNotes.date.microsecondsSinceEpoch))}")
          ],
        ),
      ),
    );
  }
}
