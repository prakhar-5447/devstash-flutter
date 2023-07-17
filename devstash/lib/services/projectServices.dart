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
            'v2.local.XTqynB9B5DI6C6kEd-ouwrjJoZzT-rMq7Fnaw4IKdgIy7AtHUCg5Bx50Hruf9rh3D1NG45U5W1JOWwsTXMydhAKNVmGt8ikRC250GzS4oGf5gSE89rXYPFASP6SbWY8wBMGu2kn7KgiHm9EI4_P2EVDgudM23Z6RVDGU1JboZB7fUJzyVf09Z0BxFdUXXX0UuSKXuIHpu6mhNR41WFSVo0IgRlbY3LRTW15v6nxwy6LjUCd_A9ocbaVpo5y0c9orsgJvbOq3n4xIxYOb0kA4IvzGYjy0jdhIAXzUFp2Agc1F2Y_tSZ0q96QejzUaZ5N1.bnVsbA',
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
            'v2.local.Gdj7OTm8jFjgmU6D-Mqoy4YboGlJA6CC1ytk2jMQsoORoBVdR-iIGx-MW4Xd603RkHbpQFDRtB1tNXRnETyiD4FyirXUuExgZGC2lHvRlb-AlcUikcWsd1_AiBm7cwYBY0tggGJeB7qsf-HsjrvggDZjSP9H276i3mBIAiyYmvtDu7WOE8mi1Em-uEPLNt1vOK5ABCnNSylZiz42wzhiI7oO3m6Wbu_AOQgeydBkesx0-4pCu0wNWBgbg_fTzxcc0fJpyKf0tee_sbfu2Pw90s0SyLr2mnoiStv5dkAfEJlu_I29cD1sMzF1VJLUsBCw.bnVsbA',
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

  Future<dynamic> daleteProject(String projectid) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.deleteProjectEndpoint +
          projectid);
      var headers = {
        'Authorization':
            'v2.local.Gdj7OTm8jFjgmU6D-Mqoy4YboGlJA6CC1ytk2jMQsoORoBVdR-iIGx-MW4Xd603RkHbpQFDRtB1tNXRnETyiD4FyirXUuExgZGC2lHvRlb-AlcUikcWsd1_AiBm7cwYBY0tggGJeB7qsf-HsjrvggDZjSP9H276i3mBIAiyYmvtDu7WOE8mi1Em-uEPLNt1vOK5ABCnNSylZiz42wzhiI7oO3m6Wbu_AOQgeydBkesx0-4pCu0wNWBgbg_fTzxcc0fJpyKf0tee_sbfu2Pw90s0SyLr2mnoiStv5dkAfEJlu_I29cD1sMzF1VJLUsBCw.bnVsbA',
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
            'v2.local.dLv3KeEprkavv6JMcmlWM9E86zcjYQRc60Zds18Ynx5TSB3CXouCFT0E3_olRTkVFdYjTNmpP6AzymATOrvFh3Tte6zCAshWNk6tT8B-ODL_lOeETn7yRNkOv4EiwQeMfUhrTRC2CU5FN6e9UogtrLyFR4rb208imFVTGI6dtqFjiBaI-nujdS026wa_o13urVm2Bs2om6_FO2eoFS-terNJ4mSs4y_IoOmHNEhGsHP5KH9NggKNg9qkcL5NFanvoC20zVYRjqyYMaB0um5w0gUrBtAk5FN4b-UIRmtzJRjoUSSv9WNKBJ9xQb7w_g.bnVsbA',
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
    image,
    title,
    description,
    createdDate,
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
