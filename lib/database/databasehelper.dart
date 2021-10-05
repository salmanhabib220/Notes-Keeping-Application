import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:note_keeper_app/models/note.dart';

class Databasehelper {
  //  static Databasehelper _databasehelper;
  late Database _database;

  // Databasehelper._createInstance();

  String notestable = 'notes_table';
  String colid = 'id';
  String coltitle = 'title';
  String coldescription = 'description';
  String coldate = 'date';
  String colpriority = 'priority';

  // factory Databasehelper() {
  //   // ignore: unnecessary_null_comparison
  //   if (_databasehelper == null) {
  //     _databasehelper = Databasehelper._createInstance();
  //   }
  //   return _databasehelper;
  // }

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var notesdatabase =
        await openDatabase(path, version: 1, onCreate: _createdb);
    return notesdatabase;
  }

  void _createdb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $notestable($colid INTEGER PRIMARY KEY AUTOINCREMENT, $coltitle TEXT,$coldescription TEXT, $colpriority INTEGER, $coldate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(notestable, orderBy: '$colpriority ASC');
    return result;
  }

  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(notestable, note.toMap(),
        where: '$colid ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> insertNote(Note note) async {
    var db = await this.database;
    var result = await db.insert(notestable, note.toMap());
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $notestable WHERE $colid = $id');
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var notemaplist = await getNoteMapList();
    int count = notemaplist.length;

    // ignore: deprecated_member_use
    List<Note> notelist = <Note>[];

    for (int i = 0; i < count; i++) {
      notelist.add(Note.fromMapobject(notemaplist[i]));
    }
    return notelist;
  }

  Future<int?> getcount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $notestable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }
}
