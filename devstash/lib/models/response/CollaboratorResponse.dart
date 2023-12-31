class CollaboratorResponse {
  String _UserId;
  String _Name;

  CollaboratorResponse(
    this._UserId,
    this._Name,
  );

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserId, otherUserIds: $_UserId}';
  }

  String get userId => _UserId;
  String get name => _Name;
}
