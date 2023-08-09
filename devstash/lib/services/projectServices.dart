import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class ProjectServices {
  Future<ProjectResponse?> addProject(
      String token, ProjectRequest project) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.createProjectEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.post(url,
          headers: headers, body: jsonEncode(project.toJson()));
      if (response.statusCode == 200) {
        ProjectResponse project = projectFromJson(response.body);
        return project;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ProjectResponse>?> getProjects(String token) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getProjectsEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<ProjectResponse> project = projectsFromJson(response.body);
        return project;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ProjectResponse?> getProjectById(String projectId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.getProjectByIdEndpoint +
          projectId);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        ProjectResponse project = projectFromJson(response.body);
        return project;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<CollaboratorResponse>?> getCollaboratorUsers(
      List<String> userid) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getCollaboratorUsersEndpoint);

      var response = await http.post(url, body: jsonEncode(userid));
      if (response.statusCode == 200) {
        List<CollaboratorResponse> users = userFromJson(response.body);
        return users;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> deleteProject(String token, String projectid) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.deleteProjectEndpoint +
          projectid);
      var headers = {
        'Authorization': token,
      };

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ProjectResponse?> updateProject(
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
      if (response.statusCode == 200) {
        ProjectResponse project = projectFromJson(response.body);
        return project;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

List<CollaboratorResponse> userFromJson(String json) {
  final userData = jsonDecode(json);
  List<CollaboratorResponse> collaboratorUsers = [];

  for (var user in userData) {
    CollaboratorResponse userInfo =
        CollaboratorResponse(user['userId'], user['avatar'], user['name']);
    collaboratorUsers.add(userInfo);
  }
  return collaboratorUsers;
}

ProjectResponse projectFromJson(String json) {
  final projectData = jsonDecode(json);

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
  final parsedData = jsonDecode(json);
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
