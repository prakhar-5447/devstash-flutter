class SocialsResponse {
  String _userId;
  String _twitter;
  String _instagram;
  String _linkedin;
  String _github;
  String _other;

  SocialsResponse(this._userId, this._twitter, this._instagram, this._linkedin,
      this._github, this._other);

  // Getters
  String get userId => _userId;
  String get twitter => _twitter;
  String get instagram => _instagram;
  String get linkedin => _linkedin;
  String get github => _github;
  String get other => _other;

  // Setters
  set userId(String value) => _userId = value;
  set twitter(String value) => _twitter = value;
  set instagram(String value) => _instagram = value;
  set linkedin(String value) => _linkedin = value;
  set github(String value) => _github = value;
  set other(String value) => _other = value;

  @override
  String toString() {
    return 'SocialsResponse{userId: $_userId, twitter: $_twitter, instagram: $_instagram, github: $_github, linkedin: $_linkedin, other : $_other}';
  }
}
