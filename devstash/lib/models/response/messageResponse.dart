class MessageResponse {
  String _ID;
  String _UserId;
  String _Subject;
  String _Description;
  String _SenderName;
  String _SenderEmail;
  String _CreatedAt;

  MessageResponse(
    this._ID,
    this._UserId,
    this._Subject,
    this._Description,
    this._SenderName,
    this._SenderEmail,
    this._CreatedAt,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_ID, userid: $_UserId, subject: $_Subject, description: $_Description, senderName: $_SenderName, senderEmail: $_SenderEmail, createdAt: $_CreatedAt}';
  }

  String get id => _ID;
  String get userId => _UserId;
  String get subject => _Subject;
  String get description => _Description;
  String get senderName => _SenderName;
  String get senderEmail => _SenderEmail;
  String get createdAt => _CreatedAt;
}
