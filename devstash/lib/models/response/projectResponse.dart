class ProjectResponse {
  String _UserID;
  String _ID;
  String _Image;
  String _Title;
  String _Url;
  String _Description;
  String _CreatedDate;
  List<String> _Technologies;
  List<String> _CollaboratorsID;
  String _ProjectType;
  List<String> _Hashtags;

  ProjectResponse(
    this._UserID,
    this._ID,
    this._CreatedDate,
    this._Image,
    this._Title,
    this._Url,
    this._Description,
    this._Technologies,
    this._CollaboratorsID,
    this._ProjectType,
    this._Hashtags,
  );

  String get userID => _UserID;
  String get id => _ID;
  String get image => _Image;
  String get title => _Title;
  String get url => _Url;
  String get description => _Description;
  String get createdDate => _CreatedDate;
  List<String> get technologies => _Technologies;
  List<String> get collaboratorsID => _CollaboratorsID;
  String get projectType => _ProjectType;
  List<String> get hashtags => _Hashtags;

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserID, id: $_ID, image: $_Image, title: $_Title, url: $_Url, description: $_Description, createdDate: $_CreatedDate, technologies: $_Technologies, collaboratorsID: $_CollaboratorsID, projectType: $_ProjectType, hashtags: $_Hashtags}';
  }
}
