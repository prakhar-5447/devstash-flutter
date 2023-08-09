class ProjectRequest {
  String _Image;
  String _Title;
  String _Description;
  String _Url;
  List<String> _Technologies;
  List<String> _CollaboratorsID;
  String _ProjectType;
  List<String> _Hashtags;

  ProjectRequest(
    this._Image,
    this._Title,
    this._Url,
    this._Description,
    this._Technologies,
    this._CollaboratorsID,
    this._ProjectType,
    this._Hashtags,
  );

  @override
  String toString() {
    return 'ProjectResponse{image: $_Image, title: $_Title, url: $_Url,description: $_Description, technologies: $_Technologies, collaboratorsID: $_CollaboratorsID, projectType: $_ProjectType, hashtags: $_Hashtags}';
  }

  Map<String, dynamic> toJson() {
    return {
      'image': _Image,
      'title': _Title,
      'url': _Url,
      'description': _Description,
      'technologies': _Technologies,
      'collaboratorsID': _CollaboratorsID,
      'projectType': _ProjectType,
      'hashtags': _Hashtags,
    };
  }
}
