class ProjectRequest {
  String _UserID;
  String _ID;
  String _Image;
  String _Title;
  String _Description;
  String _CreatedDate;
  String _Technologies;
  String _CollaboratorsID;
  String _ProjectType;
  String _Hashtags;

  ProjectRequest(
    this._UserID,
    this._ID,
    this._CreatedDate,
    this._Image,
    this._Title,
    this._Description,
    this._Technologies,
    this._CollaboratorsID,
    this._ProjectType,
    this._Hashtags,
  );

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserID, id: $_ID, image: $_Image, title: $_Title, description: $_Description, createdDate: $_CreatedDate, technologies: $_Technologies, collaboratorsID: $_CollaboratorsID, projectType: $_ProjectType, hashtags: $_Hashtags}';
  }
}
