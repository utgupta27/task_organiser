import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_organiser/homePage/homePage.dart';

final FirebaseFirestore _firebase = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firebase
    .collection(HomePageState.data[0])
    .doc('notes')
    .collection('items');

class EditNotesPage extends StatefulWidget {
  const EditNotesPage({Key? key}) : super(key: key);

  @override
  EditNotesPageState createState() => EditNotesPageState();
}

class EditNotesPageState extends State<EditNotesPage> {
  var dropdownVal = "Teal";
  static var id;
  static var title;
  static var subTitle;
  static var color;
  static var date;

  var titleController = TextEditingController();
  var subTitleController = TextEditingController();

  @override
  void initState() {
    setState(() {
      super.initState();
    });
    id = EditNotesPageState.id;
    titleController.text = EditNotesPageState.title;
    subTitleController.text = EditNotesPageState.subTitle;
    dropdownVal = EditNotesPageState.color;
    date = DateTime.now();
  }

  static sendData(aid, atitle, asubTitle, acolor, adate) {
    id = aid;
    title = atitle;
    subTitle = asubTitle;
    color = acolor;
    date = adate;
  }

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

  onButtonPressed() async {
    final DocumentReference _userDocs =
        _userCollection.doc(EditNotesPageState.id);
    _userDocs.set({
      'title': titleController.value.text,
      'docID': _userDocs.id,
      'subtitle': subTitleController.value.text,
      'color': color,
      'date': DateTime.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add New Note")),
        backgroundColor: Colors.blue[800],
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // handle the press
                title = titleController.value.text;
                subTitle = subTitleController.value.text;
                onButtonPressed();
                setState(() {
                  super.setState(() {});
                });
                Navigator.pop(context, true);
                setState(() {
                  super.setState(() {});
                });
                Navigator.pop(context, true);
              },
              icon: Icon(
                Icons.file_upload_outlined,
                size: 35,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: titleController,
                autocorrect: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.black87,
                  icon: Icon(Icons.new_label_outlined, size: 40),
                  labelText: "Title",
                  labelStyle: TextStyle(),
                  hintText: 'e.g, Flutter Framework',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                // autofocus: true,

                textInputAction: TextInputAction.newline,
                maxLines: 10,
                controller: subTitleController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.black87,
                  icon: Icon(Icons.subtitles_outlined, size: 40),
                  labelText: "Details",
                  labelStyle: TextStyle(),
                  hintText:
                      'e.g, Flutter is a cross-platform Application Development SDK which is designed to build beautiful applications that are natively compiled.',
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ListTile(
                    title: Text(
                      "Select Note Colour",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 65,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: DropdownButton<String>(
                        value: dropdownVal,
                        isExpanded: true,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18),
                        underline: Container(
                          height: 2,
                          // width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownVal = newValue!;
                            color = dropdownVal;
                          });
                        },
                        items: <String>[
                          'Pink',
                          'Purple',
                          'Blue',
                          'Cyan',
                          'Teal',
                          'Yellow',
                          'Orange',
                          'Brown'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: getColor(value),
                                    // backgroundColor: getColor(value),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
