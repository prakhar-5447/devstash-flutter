class BookmarkResponse {
  String _UserId;
  List<String> _OtherUserIds;

  BookmarkResponse(
    this._UserId,
    this._OtherUserIds,
  );

  @override
  String toString() {
    return 'ProjectResponse{userId: $_UserId, otherUserIds: $_OtherUserIds}';
  }
}
