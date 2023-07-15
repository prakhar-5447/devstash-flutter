class FavoriteResponse {
  String _UserId;
  List<String> _OtherUserIds;

  FavoriteResponse(
    this._UserId,
    this._OtherUserIds,
  );

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserId, otherUserIds: $_OtherUserIds}';
  }
} 
