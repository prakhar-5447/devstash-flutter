class SignupRequest {
  String _Name;
  String _Username;
  String _Email;
  String _Password;

  SignupRequest(
    this._Name,
    this._Username,
    this._Email,
    this._Password,
  );

  @override
  String toString() {
    return 'ProjectResponse{name: $_Name, username: $_Username, password: $_Password, email: $_Email}';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _Name,
      'username': _Username,
      'password': _Password,
      'email': _Email,
    };
  }
}
