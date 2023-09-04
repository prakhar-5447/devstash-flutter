class GithubUserResponse {
  String _Id;
  String _Login;
  String _Name;
  String _Avatar_url;
  String _Bio;
  String _Public_repos;
  String _Followers;
  String _Following;

  GithubUserResponse(
    this._Id,
    this._Login,
    this._Name,
    this._Avatar_url,
    this._Bio,
    this._Public_repos,
    this._Followers,
    this._Following,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, login: $_Login, name: $_Name, avatar_url: $_Avatar_url, bio: $_Bio, public_repos: $_Public_repos, followers: $_Followers, following: $_Following}';
  }

  String get id => _Id;
  String get login => _Login;
  String get name => _Name;
  String get avatar_url => _Avatar_url;
  String get bio => _Bio;
  String get public_repos => _Public_repos;
  String get followers => _Followers;
  String get following => _Following;
}
