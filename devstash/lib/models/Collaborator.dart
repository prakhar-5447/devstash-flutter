class Collaborator {
  String _avatar;
  String _name;

  Collaborator(this._avatar, this._name);

  String get avatar => _avatar;
  set avatar(String value) => _avatar = value;

  String get name => _name;
  set name(String value) => _name = value;
}
