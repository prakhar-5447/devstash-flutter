class UserResponse {
  String _ID;
  String _Name;
  String _Avatar;
  String _Username;
  String _Password;
  String _Email;
  String _Phone;
  String _Description;

  UserResponse(
    this._ID,
    this._Name,
    this._Avatar,
    this._Username,
    this._Password,
    this._Email,
    this._Phone,
    this._Description,
  );

  String get ID => _ID;
  set ID(String value) => _ID = value;

  String get Name => _Name;
  set Name(String value) => _Name = value;

  String get Avatar => _Avatar;
  set Avatar(String value) => _Avatar = value;

  String get Username => _Username;
  set Username(String value) => _Username = value;

  String get Password => _Password;
  set Password(String value) => _Password = value;

  String get Email => _Email;
  set Email(String value) => _Email = value;

  String get Phone => _Phone;
  set Phone(String value) => _Phone = value;

  String get Description => _Description;
  set Description(String value) => _Description = value;

  @override
  String toString() {
    return 'ProjectResponse{iD: $_ID, name: $_Name, avatar: $_Avatar, username: $_Username, password: $_Password, email: $_Email, phone: $_Phone, description: $_Description}';
  }
}
