class GithubTokenErrorResponse {
  String _Error;
  String _Error_description;
  String _Error_uri;

  GithubTokenErrorResponse(
    this._Error,
    this._Error_description,
    this._Error_uri,
  );

  @override
  String toString() {
    return 'ProjectResponse{error: $_Error, error_description: $_Error_description, error_uri: $_Error_uri}';
  }

  String get error => _Error;
  String get error_description => _Error_description;
  String get error_uri => _Error_uri;
}
