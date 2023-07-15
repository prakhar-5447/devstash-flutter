class LoginRequest {
  String _UsernameOrEmail;
  String _Password;

  LoginRequest(
    this._UsernameOrEmail,
    this._Password,
  );

  @override
  String toString() {
    return 'ProjectResponse{usernameOrEmail: $_UsernameOrEmail, password: $_Password}';
  }
}
