import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_organiser/addNewTaskPage.dart';
import 'package:task_organiser/dbHandler.dart';
import 'package:task_organiser/dataModle.dart';

class TodoPage extends StatefulWidget {
  // const TodoPage({Key? key}) : super(key: key);
  static List<List<String>> tempData = [
    [
      'Demo Task',
      'Added Details or Summary Appears Here',
      'High',
      '27/07/21',
      DateTime.now().toString()
    ]
  ];

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  _getRequests() async {}
  update() {
    setState(() {
      super.setState(() {});
    });
  }

  static newTaskData(title, subTitle, priority, dueDate) {
    TodoPage.tempData
        .add([title, subTitle, priority, dueDate, DateTime.now().toString()]);
  }

  Color getColor(int index) {
    if (TodoPage.tempData[index][2] == "High") {
      return Colors.red;
    } else if (TodoPage.tempData[index][2] == "Low") {
      return Colors.yellow;
    } else
      return Colors.green;
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  onButtonPressed(index) async {
    // print("Button $index pressed");
    TodoPage.tempData.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(TodoPage.tempData);
    update();
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: TodoPage.tempData.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 105,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border(
                              left: BorderSide(
                                  width: 7.0, color: getColor(index)))),
                      child: ListTile(
                        // leading: Icon(Icons.arrow_right_rounded),
                        minLeadingWidth: 5,
                        title: Text(TodoPage.tempData[index][0]),
                        subtitle: Text(TodoPage.tempData[index][1]),
                        trailing: ElevatedButton(
                          child: Icon(Icons.done_outline_rounded),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            onButtonPressed(index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            super.setState(() {});
          });
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (_) => new AddNewTaskPage()),
              )
              .then(onGoBack);
        },
        child: Icon(Icons.add_task_rounded),
        elevation: 10,
        backgroundColor: Colors.blue[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
