import 'package:flutter/material.dart';
import 'package:task_organiser/databaseHandler/databaseHandlerNotes.dart';
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
    date = adate.toString().substring(0, 10);
  }

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

onButtonPressed(index) async {
  print('INDEX to be deleted: $index');
  print(ViewNotes.id);
  await DatabaseHandlerNotes.instance.delete(index);
  // setState(() {
  //   super.setState(() {});
  // });
}

class _ViewNotesState extends State<ViewNotes> {
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
                onButtonPressed(int.parse(ViewNotes.id.toString()));
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
                child: Text(
                  "${ViewNotes.subTitle}",
                  style: TextStyle(fontSize: 25),
                ),
              )),
            ),
            Text("${ViewNotes.date}")
          ],
        ),
      ),
    );
  }
}
