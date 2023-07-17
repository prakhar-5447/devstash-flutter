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
}
