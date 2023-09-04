import 'package:devstash/models/github/githubRepoAssigneeResponse.dart';

class GithubRepoIssueResponse {
  String _Id;
  String _Number;
  String _Title;
  GithubRepoAssigneeResponse _User;
  List<GithubRepoAssigneeResponse> _Assignees;
  String _Html_url;

  GithubRepoIssueResponse(
    this._Id,
    this._Number,
    this._Title,
    this._User,
    this._Assignees,
    this._Html_url,
  );

  @override
  String toString() {
    return 'ProjectResponse{id: $_Id, number: $_Number, title: $_Title, user: $_User, assignees: $_Assignees, html_url: $_Html_url}';
  }

  String get id => _Id;
  String get number => _Number;
  String get title => _Title;
  GithubRepoAssigneeResponse get user => _User;
  List<GithubRepoAssigneeResponse> get assignees => _Assignees;
  String get html_url => _Html_url;
}
