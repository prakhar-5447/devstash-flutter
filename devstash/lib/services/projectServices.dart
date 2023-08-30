import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class ProjectServices {
  dynamic addProject(String token, ProjectRequest project) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.createProjectEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.post(url,
          headers: headers, body: jsonEncode(project.toJson()));
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getProjects(String token) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getProjectsEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      return datasFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getProjectById(String projectId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.getProjectByIdEndpoint +
          projectId);

      var response = await http.get(url);
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getCollaboratorUsers(List<String> userid) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getCollaboratorUsersEndpoint);

      var response = await http.post(url, body: jsonEncode(userid));
      return collaboratorDataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic deleteProject(String token, String projectid) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.deleteProjectEndpoint +
          projectid);
      var headers = {
        'Authorization': token,
      };

      var response = await http.delete(url, headers: headers);
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic updateProject(
      String token, ProjectRequest project, String projectId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.updateProjectEndpoint +
          projectId);
      var headers = {
        'Authorization': token,
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(project.toJson()));
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}

dynamic collaboratorDataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    List<CollaboratorResponse> collaborator = userFromJson(json);
    return {"success": success, "msg": msg, "data": collaborator};
  }

  return {"success": success, "msg": msg, "data": {}};
}

List<CollaboratorResponse> userFromJson(String json) {
  final userData = jsonDecode(json)['data'];
  List<CollaboratorResponse> collaboratorUsers = [];

  for (var user in userData) {
    CollaboratorResponse userInfo =
        CollaboratorResponse(user['userId'], user['name']);
    collaboratorUsers.add(userInfo);
  }
  return collaboratorUsers;
}

dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    ProjectResponse project = projectFromJson(json);
    return {"success": success, "msg": msg, "data": project};
  }

  return {"success": success, "msg": msg, "data": {}};
}

dynamic datasFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    List<ProjectResponse> project = projectsFromJson(json);
    return {"success": success, "msg": msg, "data": project};
  }

  return {"success": success, "msg": msg, "data": {}};
}

ProjectResponse projectFromJson(String json) {
  final projectData = jsonDecode(json)['data'];

  String userID = projectData['UserID'];
  String id = projectData['ID'];
  String image = projectData['Image'];
  String title = projectData['Title'];
  String url = projectData['Url'];
  String description = projectData['Description'];
  String createdDate = projectData['CreatedDate'];
  List<String> technologies = List<String>.from(projectData['Technologies']);
  List<String> collaboratorsID =
      List<String>.from(projectData['CollaboratorsID']);
  String projectType = projectData['ProjectType'];
  List<String> hashtags = List<String>.from(projectData['Hashtags']);

  ProjectResponse project = ProjectResponse(
    userID,
    id,
    createdDate,
    image,
    title,
    url,
    description,
    technologies,
    collaboratorsID,
    projectType,
    hashtags,
  );

  return project;
}

List<ProjectResponse> projectsFromJson(String json) {
  final parsedData = jsonDecode(json)['data'];
  List<ProjectResponse> projects = [];

  for (var projectData in parsedData) {
    String userID = projectData['UserID'];
    String id = projectData['ID'];
    String image = projectData['Image'];
    String title = projectData['Title'];
    String url = projectData['Url'];
    String description = projectData['Description'];
    String createdDate = projectData['CreatedDate'];
    List<String> technologies = List<String>.from(projectData['Technologies']);
    List<String> collaboratorsID =
        List<String>.from(projectData['CollaboratorsID']);
    String projectType = projectData['ProjectType'];
    List<String> hashtags = List<String>.from(projectData['Hashtags']);

    ProjectResponse project = ProjectResponse(
      userID,
      id,
      createdDate,
      image,
      title,
      url,
      description,
      technologies,
      collaboratorsID,
      projectType,
      hashtags,
    );
    projects.add(project);
  }

  return projects;
}
