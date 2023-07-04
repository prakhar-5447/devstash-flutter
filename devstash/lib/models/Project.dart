class Project {
  String _title;
  String _desc;
  DateTime _createdAt;
  String _link;
  String _image;
  List<String> _technologies;
  List<String> _collaboraotrs;
  List<String> _hashTags;

  Project(this._title, this._desc, this._createdAt, this._link, this._image,
      this._technologies, this._collaboraotrs, this._hashTags);

  String get title => _title;
  set title(String value) => _title = value;

  String get desc => _desc;
  set desc(String value) => _desc = value;

  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) => _createdAt = value;

  String get link => _link;
  set link(String value) => _link = value;

  String get image => _image;
  set image(String value) => _image = value;

  List<String> get technologies => _technologies;
  set technologies(List<String> value) => _technologies = value;

  List<String> get collaboraotrs => _collaboraotrs;
  set collaboraotrs(List<String> value) => _collaboraotrs = value;

  List<String> get hashTags => _hashTags;
  set hashTags(List<String> value) => _hashTags = value;
}
