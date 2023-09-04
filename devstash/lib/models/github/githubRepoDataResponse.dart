class GithubRepoDataResponse {
  String _Id;
  String _Name;

  GithubRepoDataResponse(this._Id, this._Name);

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, name: $_Name}';
  }

  String get id => _Id;
  String get name => _Name;
}
