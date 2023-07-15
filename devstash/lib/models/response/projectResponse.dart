class ProjectResponse {
  String _Image;
  String _Title;
  String _Description;
  String _Technologies;
  String _CollaboratorsID;
  String _ProjectType;
  String _Hashtags;

  ProjectResponse(
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
    return 'ProjectResponse{image: $_Image, title: $_Title, description: $_Description, technologies: $_Technologies, collaboratorsID: $_CollaboratorsID, projectType: $_ProjectType, hashtags: $_Hashtags}';
  }
}
