class SigninRequest {
  String _UsernameOrEmail;
  String _Password;
  String _FCMToken;

  SigninRequest(
    this._UsernameOrEmail,
    this._Password,
    this._FCMToken,
  );

  @override
  String toString() {
    return 'ProjectResponse{usernameOrEmail: $_UsernameOrEmail, password: $_Password, fcmtoken: $_FCMToken}';
  }

  Map<String, dynamic> toJson() {
    return {
      'usernameOrEmail': _UsernameOrEmail,
      'password': _Password,
      'fcmtoken': _FCMToken,
    };
  }
}
