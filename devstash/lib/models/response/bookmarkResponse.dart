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

  String get userId => _UserId;
  List<String> get otherUserIds => _OtherUserIds;
  int get userLength => otherUserIds.length;
}
