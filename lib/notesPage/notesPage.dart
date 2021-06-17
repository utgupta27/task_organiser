import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:task_organiser/dataModle/notesDataModle.dart';
import 'package:task_organiser/notesPage/addNewNotesPage.dart';
import 'package:task_organiser/notesPage/viewNotes.dart';
import 'package:task_organiser/databaseHandler/databaseHandlerNotes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  onGoBack(dynamic value) {
    refreshNotes();
    setState(() {});
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

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    this.notes = await DatabaseHandlerNotes.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? Center(
                  child: Text("Nothing to Show",
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                )
              : new StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: notes.length,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.fit(2);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        child: new Container(
                          height: 190,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600]!,
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                ), //BoxShadow
                              ],
                              color: getColor(notes[index].color)),
                          // color: Colors.amber,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 42,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${notes[index].title}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 125,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    '${notes[index].subtitle}',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        "${notes[index].date.substring(0, 10)}")),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          ViewNotes.sendData(
                              notes[index].id,
                              notes[index].title,
                              notes[index].subtitle,
                              notes[index].color,
                              notes[index].date);
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                    builder: (_) => new ViewNotes()),
                              )
                              .then(onGoBack);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            super.setState(() {});
          });
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (_) => new AddNewNotesPage()),
              )
              .then(onGoBack);
        },
        backgroundColor: Colors.blue[800],
        elevation: 10,
        child: Icon(
          Icons.note_add_outlined,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
