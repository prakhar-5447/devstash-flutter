class GithubRepoContributerResponse {
  String _Id;
  String _Login;
  String _Avatar_url;
  String _Url;
  String _Contributions;

  GithubRepoContributerResponse(
    this._Id,
    this._Login,
    this._Avatar_url,
    this._Url,
    this._Contributions,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, login: $_Login, avatar_url: $_Avatar_url, url: $_Url, contributions: $_Contributions}';
  }

  String get id => _Id;
  String get login => _Login;
  String get avatar_url => _Avatar_url;
  String get url => _Url;
  String get contributions => _Contributions;
}
