import 'package:flutter/material.dart';
import 'package:task_organiser/data/todoData.dart';
import 'package:task_organiser/addNewTaskPage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var todoData = Todo.getData;
  getTitle(index) {
    return todoData[index]['title'];
  }

  getSubTitle(index) {
    return todoData[index]['subtitle'];
  }

  getColor(index) {
    return todoData[index]['color'];
  }

  onButtonPressed(index) {
    print("Button $index pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: todoData.length,
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
                        title: Text(getTitle(index)),
                        subtitle: Text(getSubTitle(index)),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskPage()),
          );
        },
        child: Icon(Icons.add_task_rounded),
        elevation: 10,
        backgroundColor: Colors.blue[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
