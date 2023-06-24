class Task {
  String _title;
  String _desc;

  Task(this._title, this._desc);
  String get title => _title;
  set title(String value) => _title = value;

  String get desc => _desc;
  set desc(String value) => _desc = value;
}
