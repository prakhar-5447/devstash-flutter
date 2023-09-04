class GithubAuthenticationErrorResponse {
  String _Message;
  String _Documentation_url;

  GithubAuthenticationErrorResponse(
    this._Message,
    this._Documentation_url,
  );

  @override
  String toString() {
    return 'ProjectResponse{message: $_Message, documentation_url: $_Documentation_url}';
  }

  String get message => _Message;
  String get documentation_url => _Documentation_url;
}
