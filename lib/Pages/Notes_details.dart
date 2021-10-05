import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/note.dart';

// ignore: must_be_immutable
class Notesdetails extends StatefulWidget {
  final String appbartitle;
  final Note note;
  Notesdetails(this.note, this.appbartitle);

  @override
  _NotesdetailsState createState() =>
      _NotesdetailsState(this.note, this.appbartitle);
}

class _NotesdetailsState extends State<Notesdetails> {
  static var _priorities = ["High", "Low"];
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  String appBartitle = "";
  Note note;
  
  _NotesdetailsState(this.note, this.appBartitle);
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    return WillPopScope(
      onWillPop: () {
        return movetobackscreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBartitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              movetobackscreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: [
              //Drop Down to Select Which priority of Note is this
              ListTile(
                title: DropdownButton(
                  items: _priorities.map((String dropdownstring) {
                    return DropdownMenuItem<String>(
                      value: dropdownstring,
                      child: Text(dropdownstring),
                    );
                  }).toList(),
                  style: textStyle,
                  value: "Low",
                  onChanged: (valueSelectedByUser) {
                    setState(() {});
                  },
                ),
              ),
              //First Text Form Field title
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  controller: _titlecontroller,
                  style: textStyle,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    hintText: "Enter your title",
                    hintStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              //Second Form Text Field Description
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: _descriptioncontroller,
                  style: textStyle,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: textStyle,
                    hintText: "Enter your Notes Description Here",
                    hintStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                      width: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Naviagtion function to back to the screen
  movetobackscreen() {
    Navigator.pop(context);
  }
}
