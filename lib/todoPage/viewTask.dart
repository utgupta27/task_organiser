import 'package:flutter/material.dart';

class ViewTask extends StatefulWidget {
  // const ViewTask({Key? key}) : super(key: key);
  static var title;
  static var subTitle;
  static var priority;
  static var dueDate;
  static var date;

  static sendData(atitle, asubTitle, apriority, adueDate, adate) {
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
        backgroundColor: Colors.blue[800],
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
                    fontSize: 40,
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
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 30, 10),
                      child: Text(
                        ViewTask.subTitle,
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
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
