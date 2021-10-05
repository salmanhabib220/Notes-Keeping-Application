class Note {
  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;

  Note(this._title, this._date, this._priority, [_description]);
  Note.withId(this._id, this._title, this._date, this._priority,
      [_description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String newtitle) {
    if (newtitle.length <= 150) {
      this._title = newtitle;
    }
  }

  set description(String newdescription) {
    if (newdescription.length <= 500) {
      this._description = newdescription;
    }
  }

  set priority(int newpriority) {
    if (newpriority >= 1 && newpriority <= 2) {
      this._priority = newpriority;
    }
  }

  set date(String newdate) {
    this._date = newdate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Note.fromMapobject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date']; 
  }
}
