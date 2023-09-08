class RecommendedUser {
  String _id;
  String _name;
  String _avatar;

  RecommendedUser(
    this._id,
    this._name,
    this._avatar,
  );

  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  String get avatar => _avatar;
  set avatar(String value) => _avatar = value;

  @override
  String toString() {
    return 'UserState{iD: $_id, name: $_name, avatar: $_avatar}';
  }
}
