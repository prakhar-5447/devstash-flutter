class GithubTokenRequest {
  String _Client_id;
  String _Client_secret;
  String _Code;
  String _Redirect_uri;

  GithubTokenRequest(
    this._Client_id,
    this._Client_secret,
    this._Code,
    this._Redirect_uri,
  );

  @override
  String toString() {
    return 'ProjectResponse{client_id: $_Client_id, client_secret: $_Client_secret, code: $_Code, redirect_uri: $_Redirect_uri}';
  }

  String get client_id => _Client_id;
  String get client_secret => _Client_secret;
  String get code => _Code;
  String get redirect_uri => _Redirect_uri;
}
