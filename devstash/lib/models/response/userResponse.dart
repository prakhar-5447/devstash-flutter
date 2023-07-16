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

  @override
  String toString() {
    return 'ProjectResponse{iD: $_ID, name: $_Name, avatar: $_Avatar, username: $_Username, password: $_Password, email: $_Email, phone: $_Phone, description: $_Description}';
  }
}
