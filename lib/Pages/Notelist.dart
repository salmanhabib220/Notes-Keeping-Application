import 'package:flutter/material.dart';
import 'package:note_keeper_app/Pages/Notes_details.dart';
import 'package:note_keeper_app/database/databasehelper.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:sqflite/sqflite.dart';

class Notelist extends StatefulWidget {
  const Notelist({Key? key}) : super(key: key);

  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  Databasehelper databasehelper = Databasehelper();
  late List<Note> notelist;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (notelist == null) {
      notelist = <Note>[];
      updatelistview();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: getNoteslistview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationpage(Note('', '', 2), "Add Note");
        },
        tooltip: "Add Notes",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteslistview() {
    TextStyle? titletext = Theme.of(context).textTheme.bodyText1;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      getcolorpriority(this.notelist[position].priority),
                  child: getIconBypriority(this.notelist[position].priority),
                ),
                title: Text(
                  this.notelist[position].title,
                  style: titletext,
                ),
                subtitle: Text(
                  this.notelist[position].description,
                  style: titletext,
                ),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    deleteitem(context, notelist[position]);
                  },
                ),
                onTap: () {
                  navigationpage(this.notelist[position], "Edit Note");
                },
              ));
        });
  }

  // leading color on Priority Bases
  Color getcolorpriority(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        // ignore: dead_code
        break;
      case 2:
        return Colors.yellow;
        // ignore: dead_code
        break;
      default:
        return Colors.yellow;
    }
  }

  // Leading Icon  on Priority bases
  Icon getIconBypriority(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        // ignore: dead_code
        break;
      case 2:
        return Icon(Icons.arrow_back_outlined);
        // ignore: dead_code
        break;
      default:
        return Icon(Icons.arrow_back_outlined);
    }
  }

  //Delete Icon
  void deleteitem(BuildContext context, Note note) async {
    int result = await databasehelper.deleteNote(note.id);
    if (result != 0) {
      showSnackBar(context, 'Note Deleted Successfully');
      updatelistview();
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Navigation Function Move to other screen
  void navigationpage(Note note, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Notesdetails(note, title);
    }));
  }

  void updatelistview() {
    final Future<Database> db = databasehelper.initializeDatabase();
    db.then((database) {
      Future<List<Note>> notelistFuture = databasehelper.getNoteList();
      notelistFuture.then((notelist) {
        setState(() {
          this.notelist = notelist;
          this.count = notelist.length;
        });
      });
    });
  }
}
