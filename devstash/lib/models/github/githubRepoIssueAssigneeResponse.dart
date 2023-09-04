class GithubRepoIssueAssigneeResponse {
  String _Id;
  String _Login;
  String _Avatar_url;
  String _Url;

  GithubRepoIssueAssigneeResponse(
    this._Id,
    this._Login,
    this._Avatar_url,
    this._Url,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, login: $_Login, avatar_url: $_Avatar_url, url: $_Url}';
  }

  String get id => _Id;
  String get login => _Login;
  String get avatar_url => _Avatar_url;
  String get url => _Url;
}
