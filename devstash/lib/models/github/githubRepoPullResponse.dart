import 'package:devstash/models/github/githubRepoIssueAssigneeResponse.dart';

class GithubRepoPullResponse {
  String _Id;
  String _Number;
  String _Title;
  String _Html_url;

  GithubRepoPullResponse(
    this._Id,
    this._Number,
    this._Title,
    this._Html_url,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, number: $_Number, title: $_Title, html_url: $_Html_url}';
  }

  String get id => _Id;
  String get number => _Number;
  String get title => _Title;
  String get html_url => _Html_url;
}
