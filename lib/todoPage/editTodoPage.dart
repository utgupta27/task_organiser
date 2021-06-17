import 'package:flutter/material.dart';
import 'package:task_organiser/dataModle/todoDataModle.dart';
import 'package:task_organiser/databaseHandler/databaseHandler.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key}) : super(key: key);

  @override
  EditTodoPageState createState() => EditTodoPageState();
}

class EditTodoPageState extends State<EditTodoPage> {
  static var dropdownValue = "Normal";
  static var id;
  static var title;
  static var subTitle;
  static var priority;
  static var dueDate;
  static var date;

  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void initState() {
    setState(() {
      super.initState();
      id = EditTodoPageState.id;
      titleController.text = EditTodoPageState.title;
      subTitleController.text = EditTodoPageState.subTitle;
      dropdownValue = EditTodoPageState.priority;
      _date = DateTime.parse(EditTodoPageState.dueDate);
      date = DateTime.now().toLocal();
    });
  }

  static sendData(aid, atitle, asubTitle, apriority, adueDate, adate) {
    id = aid;
    title = atitle;
    subTitle = asubTitle;
    priority = apriority;
    dueDate = adueDate;
    date = adate;
  }

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
        date = _date.toLocal();
      });
    }
  }

  Color? getColor(value) {
    if (value == "High") {
      return Colors.red;
    } else if (value == "Low") {
      return Colors.yellow[800];
    } else
      return Colors.green;
  }

  onButtonPressed() async {
    final newTodo = Todo(
        id: id,
        title: title.toString(),
        subtitle: subTitle.toString(),
        priority: priority.toString(),
        dueDate: dueDate.toString(),
        date: DateTime.now().toString());
    await DatabaseHandler.instance.update(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.file_upload_outlined,
              size: 35,
              color: Colors.white,
            ),
            tooltip: 'New Task',
            onPressed: () {
              // initState();
              // handle the press
              setState(() {
                title = titleController.value.text;
                subTitle = subTitleController.value.text;
              });
              onButtonPressed();
              setState(() {
                super.setState(() {});
              });
              Navigator.pop(context, true);
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
        // color: Colors.deepOrange,
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
                // autofocus: true,

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
                    // leading: Icon(
                    //   Icons.priority_high_rounded,
                    //   size: 35,
                    //   color: Colors.red,
                    // ),
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
