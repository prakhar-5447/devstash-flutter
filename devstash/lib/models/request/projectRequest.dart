class ProjectRequest {
  String _Image;
  String _Title;
  String _Description;
  List<String> _Technologies;
  List<String> _CollaboratorsID;
  String _ProjectType;
  List<String> _Hashtags;

  ProjectRequest(
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

  Map<String, dynamic> toJson() {
    return {
      'image': _Image,
      'title': _Title,
      'description': _Description,
      'technologies': _Technologies,
      'collaboratorsID': _CollaboratorsID,
      'projectType': _ProjectType,
      'hashtags': _Hashtags,
    };
  }
}
