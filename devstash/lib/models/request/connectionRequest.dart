class ConnectionRequest {
  String _Action;
  String _OtherUserId;

  ConnectionRequest(
    this._Action,
    this._OtherUserId,
  );

  @override
  String toString() {
    return 'ProjectResponse{action: $_Action, otherUserId: $_OtherUserId}';
  }

  Map<String, dynamic> toJson() {
    return {
      'action': _Action,
      'otherUserId': _OtherUserId,
    };
  }
}
