import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_organiser/homePage/homePage.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({Key? key}) : super(key: key);

  @override
  _AddNewTaskPageState createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  var dropdownValue = "Normal";

  var title;
  var subTitle;
  var priority = 'Normal';
  var dueDate;

  var titleController = TextEditingController();
  var subTitleController = TextEditingController();

  DateTime _date = DateTime.now();

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2030, 12),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  onButtonPressed() async {
    final CollectionReference _userCollection = _firebase
        .collection(HomePageState.data[0])
        .doc('todos')
        .collection('items');

    final DocumentReference _userDocs = _userCollection.doc();
    _userDocs.set({
      'title': titleController.value.text,
      'docID': _userDocs.id,
      'subtitle': subTitleController.value.text,
      'color': priority,
      'date': DateTime.now(),
      'dueDate': _date,
    });
  }

  Color? getColor(value) {
    if (value == "High") {
      return Colors.red;
    } else if (value == "Low") {
      return Colors.yellow[800];
    } else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_task_rounded,
              size: 35,
            ),
            tooltip: 'New Task',
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
            },
          ),
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
                  icon: Icon(Icons.task, size: 40),
                  labelText: "Task Name ",
                  labelStyle: TextStyle(),
                  hintText: 'e.g, List of Groceries',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                autofocus: false,
                autocorrect: true,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
                controller: subTitleController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.black87,
                  icon: Icon(Icons.subtitles_outlined, size: 40),
                  labelText: "Details",
                  labelStyle: TextStyle(
                      // color: Colors.red,
                      ),
                  hintText:
                      'e.g, Soap,Potato Chips,\nCooking Oil,Whole Wheat Flour,\nCorn Flour, Etc.',
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ListTile(
                    title: Text(
                      "Select Task Priority",
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
                        value: dropdownValue,
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
                            dropdownValue = newValue!;
                            priority = dropdownValue;
                          });
                        },
                        items: <String>['High', 'Normal', 'Low']
                            .map<DropdownMenuItem<String>>((String value) {
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
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _selectDate,
                        child: Text('SELECT DATE'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Selected DATE: ' + _date.toString().substring(0, 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
