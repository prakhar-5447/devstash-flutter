import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class ProjectServices {
  Future<ProjectResponse?> addProject(ProjectRequest project) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.createProjectEndpoint);
      var headers = {
        'Authorization':
            'v2.local.S37Eml_mUkboZ5CrtS2P_HKAUj0SW-BNbCTpewVZLAxWTRR_utI1yOrx12oTiyEXgXtcc69jxgy6J0rSNPmSoZEDncgAD5Vqqx3QeQ3cVGDY0L7DGfY3DHhJG5M4OiqS-oZDHoHFgg8pi-SrumigpJfpAe_V3NZS884Dg8Ky9IqtY8WqdKk_a67V-aejYt81lxhFnhVOnAbEUFDN1JdYXZH1xxoTNkhGdmCS45O1Rvw1TTFk1_A1QUHmI0T4MNvwpLA5wId2cfr2xUwiqpFPVQMpvvzxEDetABuG3DvQuJs0QEbGrz3UgRyw1dBxT06D.bnVsbA',
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

  Future<List<ProjectResponse>?> getProjects() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getProjectsEndpoint);
      var headers = {
        'Authorization':
            'v2.local.S37Eml_mUkboZ5CrtS2P_HKAUj0SW-BNbCTpewVZLAxWTRR_utI1yOrx12oTiyEXgXtcc69jxgy6J0rSNPmSoZEDncgAD5Vqqx3QeQ3cVGDY0L7DGfY3DHhJG5M4OiqS-oZDHoHFgg8pi-SrumigpJfpAe_V3NZS884Dg8Ky9IqtY8WqdKk_a67V-aejYt81lxhFnhVOnAbEUFDN1JdYXZH1xxoTNkhGdmCS45O1Rvw1TTFk1_A1QUHmI0T4MNvwpLA5wId2cfr2xUwiqpFPVQMpvvzxEDetABuG3DvQuJs0QEbGrz3UgRyw1dBxT06D.bnVsbA',
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

  Future<dynamic> daleteProject(String projectid) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.deleteProjectEndpoint +
          projectid);
      var headers = {
        'Authorization':
            'v2.local.S37Eml_mUkboZ5CrtS2P_HKAUj0SW-BNbCTpewVZLAxWTRR_utI1yOrx12oTiyEXgXtcc69jxgy6J0rSNPmSoZEDncgAD5Vqqx3QeQ3cVGDY0L7DGfY3DHhJG5M4OiqS-oZDHoHFgg8pi-SrumigpJfpAe_V3NZS884Dg8Ky9IqtY8WqdKk_a67V-aejYt81lxhFnhVOnAbEUFDN1JdYXZH1xxoTNkhGdmCS45O1Rvw1TTFk1_A1QUHmI0T4MNvwpLA5wId2cfr2xUwiqpFPVQMpvvzxEDetABuG3DvQuJs0QEbGrz3UgRyw1dBxT06D.bnVsbA',
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
      ProjectRequest project, String projectId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.updateProjectEndpoint +
          projectId);
      var headers = {
        'Authorization':
            'v2.local.S37Eml_mUkboZ5CrtS2P_HKAUj0SW-BNbCTpewVZLAxWTRR_utI1yOrx12oTiyEXgXtcc69jxgy6J0rSNPmSoZEDncgAD5Vqqx3QeQ3cVGDY0L7DGfY3DHhJG5M4OiqS-oZDHoHFgg8pi-SrumigpJfpAe_V3NZS884Dg8Ky9IqtY8WqdKk_a67V-aejYt81lxhFnhVOnAbEUFDN1JdYXZH1xxoTNkhGdmCS45O1Rvw1TTFk1_A1QUHmI0T4MNvwpLA5wId2cfr2xUwiqpFPVQMpvvzxEDetABuG3DvQuJs0QEbGrz3UgRyw1dBxT06D.bnVsbA',
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

ProjectResponse projectFromJson(String json) {
  final projectData = jsonDecode(json);

  String userID = projectData['UserID'];
  String id = projectData['ID'];
  String image = projectData['Image'];
  String title = projectData['Title'];
  String description = projectData['Description'];
  String createdDate = projectData['CreatedDate'];
  List<String> technologies = List<String>.from(projectData['Technologies']);
  List<String> collaboratorsID =
      List<String>.from(projectData['CollaboratorsID']);
  String projectType = projectData['ProjectType'];
  List<String> hashtags = List<String>.from(projectData['Hashtags']);

  ProjectResponse project = ProjectResponse(
    id,
    userID,
    createdDate,
    image,
    title,
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
    String description = projectData['Description'];
    String createdDate = projectData['CreatedDate'];
    List<String> technologies = List<String>.from(projectData['Technologies']);
    List<String> collaboratorsID =
        List<String>.from(projectData['CollaboratorsID']);
    String projectType = projectData['ProjectType'];
    List<String> hashtags = List<String>.from(projectData['Hashtags']);

    ProjectResponse project = ProjectResponse(
      id,
      userID,
      image,
      title,
      description,
      createdDate,
      technologies,
      collaboratorsID,
      projectType,
      hashtags,
    );

    projects.add(project);
  }

  return projects;
}
