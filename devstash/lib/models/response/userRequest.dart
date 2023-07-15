class UserRequest {
  String _ID;
  String _Name;
  String _Avatar;
  String _Username;
  List<String> _Password;
  List<String> _Email;
  String _Phone;
  List<String> _Description;

  UserRequest(
    this._ID,
    this._Name,
    this._Avatar,
    this._Username,
    this._Password,
    this._Email,
    this._Phone,
    this._Description,
  );

  @override
  String toString() {
    return 'ProjectResponse{iD: $_ID, name: $_Name, avatar: $_Avatar, username: $_Username, password: $_Password, email: $_Email, phone: $_Phone, description: $_Description}';
  }
}
