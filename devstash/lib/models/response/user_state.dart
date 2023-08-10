class UserState {
  String _id;
  String _name;
  String _avatar;
  String _username;
  String _email;
  String _description;

  UserState(
    this._id,
    this._name,
    this._avatar,
    this._username,
    this._email,
    this._description,
  );

  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  String get avatar => _avatar;
  set avatar(String value) => _avatar = value;

  String get username => _username;
  set username(String value) => _username = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get description => _description;
  set description(String value) => _description = value;

  @override
  String toString() {
    return 'UserState{iD: $_id, name: $_name, avatar: $_avatar, username: $_username, email: $_email, description: $_description}';
  }
}
