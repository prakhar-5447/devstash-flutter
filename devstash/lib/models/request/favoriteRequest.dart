class FavoriteRequest {
  String _Action;
  String _ProjectId;

  FavoriteRequest(
    this._Action,
    this._ProjectId,
  );

  @override
  String toString() {
    return 'ProjectResponse{action: $_Action, projectId: $_ProjectId}';
  }

  Map<String, dynamic> toJson() {
    return {
      'action': _Action,
      'projectId': _ProjectId,
    };
  }
}
