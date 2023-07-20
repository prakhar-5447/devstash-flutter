class FavoriteResponse {
  String _UserId;
  List<String> _ProjectIds;

  FavoriteResponse(
    this._UserId,
    this._ProjectIds,
  );

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserId, projectIds: $_ProjectIds}';
  }

  String get userId => _UserId;
  List<String> get projectIds => _ProjectIds;
  int get projectLength => _ProjectIds.length;
}
