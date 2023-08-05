class ProjectList {
  String _id;
  String _image;

  ProjectList(this._id, this._image);

  String get id => _id;
  set id(String value) => _id = value;

  String get image => _image;
  set image(String value) => _image = value;
}
