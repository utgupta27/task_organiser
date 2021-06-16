import 'package:flutter/material.dart';
import 'package:task_organiser/todoPage/addNewTaskPage.dart';
import 'package:task_organiser/todoPage/viewTask.dart';
import 'package:task_organiser/dataModle/todoDataModle.dart';
import 'package:task_organiser/databaseHandler/databaseHandler.dart';

newTaskData(title, subTitle, priority, dueDate) async {
  final newTodo = Todo(
      title: title,
      subtitle: subTitle,
      priority: priority,
      dueDate: dueDate,
      date: DateTime.now().toString());
  await DatabaseHandler.instance.create(newTodo);
}

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  late List<Todo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshTodos();
  }

  Future refreshTodos() async {
    setState(() {
      isLoading = true;
    });
    this.todos = await DatabaseHandler.instance.readAllTodos();
    setState(() {
      isLoading = false;
    });
  }

  _getRequests() async {}
  update() {
    setState(() {
      super.setState(() {});
    });
  }

  Color getColor(var color) {
    if (color == "High") {
      return Colors.red;
    } else if (color == "Low") {
      return Colors.yellow;
    } else
      return Colors.green;
  }

  onGoBack(dynamic value) {
    refreshTodos();
    setState(() {});
  }

  getSubtitle(var data) {
    if (data.length < 60) {
      return data;
    } else if (data.length >= 60) {
      return data.substring(0, 58) + "...";
    }
  }

  onButtonPressed(index) async {
    print("Button $index pressed");
    int i = int.parse(todos[index].id.toString());
    print("INDEX $i");
    print('Before ${todos[index].id}');
    await DatabaseHandler.instance.delete(i);

    refreshTodos();
    // print('After ${todos[index].id}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    update();
    // refreshTodos();
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : todos.isEmpty
              ? Center(
                  child: Text(
                    "Nothing to Show",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 110,
                            width: double.maxFinite,
                            child: Card(
                              elevation: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border(
                                        left: BorderSide(
                                            width: 7.0,
                                            color: getColor(
                                                todos[index].priority)))),
                                child: Column(
                                  children: [
                                    ListTile(
                                      // leading: Icon(Icons.arrow_right_rounded),
                                      onTap: () {
                                        // Call A function
                                        ViewTask.sendData(
                                            todos[index].title,
                                            todos[index].subtitle,
                                            todos[index].priority,
                                            todos[index].dueDate,
                                            todos[index].date);

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
                                        todos[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      subtitle: Text(
                                          getSubtitle(todos[index].subtitle)),
                                      trailing: Container(
                                        child: ElevatedButton(
                                          child:
                                              Icon(Icons.done_outline_rounded),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          onPressed: () {
                                            onButtonPressed(index);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          17, 0, 0, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Due: ${todos[index].dueDate}",
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

// class AddNewTaskPage extends StatefulWidget {
//   const AddNewTaskPage({Key? key}) : super(key: key);

//   @override
//   _AddNewTaskPageState createState() => _AddNewTaskPageState();
// }

// class _AddNewTaskPageState extends State<AddNewTaskPage> {
//   var dropdownValue = "Normal";

//   var title;
//   var subTitle;
//   var priority;
//   var dueDate;

//   var titleController = TextEditingController();
//   var subTitleController = TextEditingController();
//   var dueDateController = TextEditingController();

//   DateTime _date = DateTime(2020, 11, 17);

//   void _selectDate() async {
//     final DateTime? newDate = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: DateTime(2017, 1),
//       lastDate: DateTime(2022, 7),
//       helpText: 'Select a date',
//     );
//     if (newDate != null) {
//       setState(() {
//         _date = newDate;
//       });
//     }
//   }

//   Color? getColor(value) {
//     if (value == "High") {
//       return Colors.red;
//     } else if (value == "Low") {
//       return Colors.yellow[800];
//     } else
//       return Colors.green;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add New Task"),
//         centerTitle: true,
//         backgroundColor: Colors.blue[800],
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.add_task_rounded,
//               size: 35,
//             ),
//             tooltip: 'New Task',
//             onPressed: () {
//               // handle the press
//               title = titleController.value.text;
//               subTitle = subTitleController.value.text;
//               dueDate = dueDateController.value.text;
//               newTaskData(
//                   title, subTitle, priority, _date.toString().substring(0, 10));
//               setState(() {
//                 super.setState(() {});
//               });
//               Navigator.pop(context, true);
//               setState(() {
//                 super.setState(() {});
//               });
//               // TodoPageState.refresh();
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         // color: Colors.deepOrange,
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
//               child: TextField(
//                 keyboardType: TextInputType.text,
//                 // autofocus: true,
//                 textInputAction: TextInputAction.next,
//                 controller: titleController,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 decoration: InputDecoration(
//                   focusColor: Colors.black87,
//                   icon: Icon(Icons.task, size: 40),
//                   labelText: "Task Name ",
//                   labelStyle: TextStyle(
//                       // color: Colors.red,
//                       ),
//                   hintText: 'e.g, List of Groceries',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 20, 20, 20),
//               child: TextField(
//                 keyboardType: TextInputType.multiline,
//                 // autofocus: true,

//                 textInputAction: TextInputAction.newline,
//                 maxLines: 3,
//                 controller: subTitleController,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 decoration: InputDecoration(
//                   focusColor: Colors.black87,
//                   icon: Icon(Icons.subtitles_outlined, size: 40),
//                   labelText: "Details",
//                   labelStyle: TextStyle(
//                       // color: Colors.red,
//                       ),
//                   hintText:
//                       'e.g, Soap,Potato Chips,\nCooking Oil,Whole Wheat Flour,\nCorn Flour, Etc.',
//                 ),
//               ),
//             ),
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
//                   child: ListTile(
//                     // leading: Icon(
//                     //   Icons.priority_high_rounded,
//                     //   size: 35,
//                     //   color: Colors.red,
//                     // ),
//                     title: Text(
//                       "Select Task Priority",
//                       style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[600]),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 65,
//                   child: Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                       child: DropdownButton<String>(
//                         value: dropdownValue,
//                         isExpanded: true,

//                         // icon: const Icon(Icons.arrow_downward),
//                         // iconSize: 24,
//                         elevation: 16,
//                         style:
//                             const TextStyle(color: Colors.blue, fontSize: 18),
//                         underline: Container(
//                           height: 2,
//                           // width: MediaQuery.of(context).size.width,
//                           color: Colors.blue,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownValue = newValue!;
//                             priority = dropdownValue;
//                           });
//                         },
//                         items: <String>['High', 'Normal', 'Low']
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Center(
//                               child: Text(
//                                 value,
//                                 style: TextStyle(
//                                     color: getColor(value),
//                                     // backgroundColor: getColor(value),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 28),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       )),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(8, 20, 20, 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: _selectDate,
//                         child: Text('SELECT DATE'),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Selected DATE: ' + _date.toString().substring(0, 10),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
