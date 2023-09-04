class GithubTokenResponse {
  String _Access_token;
  String _Token_type;
  String _Scope;

  GithubTokenResponse(
    this._Access_token,
    this._Token_type,
    this._Scope,
  );

  @override
  String toString() {
    return 'ProjectResponse{token: $_Access_token, token_type: $_Token_type, scope: $_Scope}';
  }

  String get access_token => _Access_token;
  String get token_type => _Token_type;
  String get scope => _Scope;
}
