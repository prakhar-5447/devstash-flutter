class ProjectInfo {
  String _name;
  String _image;
  String _date;
  String _url;
  String _description;

  ProjectInfo(
      this._name, this._image, this._date, this._url, this._description);

  String get name => _name;
  set name(String value) => _name = value;

  String get image => _image;
  set image(String value) => _image = value;

  String get date => _date;
  set date(String value) => _date = value;

  String get url => _url;
  set url(String value) => _url = value;

  String get description => _description;
  set description(String value) => _description = value;
}
