import 'package:devstash/models/github/githubRepoIssueAssigneeResponse.dart';

class GithubRepoIssueResponse {
  String _Id;
  String _Number;
  String _Title;
  List<GithubRepoIssueAssigneeResponse> _Assignees;
  String _Html_url;

  GithubRepoIssueResponse(
    this._Id,
    this._Number,
    this._Title,
    this._Assignees,
    this._Html_url,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, number: $_Number, title: $_Title, assignees: $_Assignees, html_url: $_Html_url}';
  }

  String get id => _Id;
  String get number => _Number;
  String get title => _Title;
  List<GithubRepoIssueAssigneeResponse> get assignees => _Assignees;
  String get html_url => _Html_url;
}
