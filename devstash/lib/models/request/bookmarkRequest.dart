class BookmarkRequest {
  String _Action;
  String _OtherUserId;

  BookmarkRequest(
    this._Action,
    this._OtherUserId,
  );

  @override
  String toString() {
    return 'ProjectResponse{action: $_Action, otherUserId: $_OtherUserId}';
  }
}
