class Connection {
  String _name;
  String _avatar;

  Connection(this._name, this._avatar);

  String get name => _name;
  set name(String value) => _name = value;

  String get avatar => _avatar;
  set avatar(String value) => _avatar = value;
}
