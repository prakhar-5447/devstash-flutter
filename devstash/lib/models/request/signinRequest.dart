class SigninRequest {
  String _UsernameOrEmail;
  String _Password;

  SigninRequest(
    this._UsernameOrEmail,
    this._Password,
  );

  @override
  String toString() {
    return 'ProjectResponse{usernameOrEmail: $_UsernameOrEmail, password: $_Password}';
  }

  Map<String, dynamic> toJson() {
    return {
      'usernameOrEmail': _UsernameOrEmail,
      'password': _Password,
    };
  }
}
