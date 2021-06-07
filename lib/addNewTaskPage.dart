import 'package:flutter/material.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({Key? key}) : super(key: key);

  @override
  _AddNewTaskPageState createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  var dropdownValue = "Normal";

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
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.deepOrange,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.text,
                // autofocus: true,
                textInputAction: TextInputAction.next,
                // controller: heightController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.black87,
                  icon: Icon(Icons.task, size: 40),
                  labelText: "Task Name ",
                  labelStyle: TextStyle(
                      // color: Colors.red,
                      ),
                  hintText: 'e.g, List of Groceries',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                // autofocus: true,

                textInputAction: TextInputAction.newline,
                maxLines: 3,
                // controller: heightController,
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
            Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 20, 20),
              child: TextField(
                keyboardType: TextInputType.datetime,
                // autofocus: true,
                textInputAction: TextInputAction.next,
                // controller: heightController,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.black87,
                  icon: Icon(Icons.date_range_outlined, size: 40),
                  labelText: "Due Date",
                  labelStyle: TextStyle(
                      // color: Colors.red,
                      ),
                  hintText: 'e.g, 152',
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.priority_high_rounded,
                      size: 40,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Task Priority",
                      style: TextStyle(
                          fontSize: 30,
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

                        // icon: const Icon(Icons.arrow_downward),
                        // iconSize: 24,
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
                                  // color: getColor(value),
                                  fontWeight: FontWeight.bold,
                                ),
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
