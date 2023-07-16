import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/response/projectResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class PrjectServices {
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
        List<ProjectResponse> project = projectFromJson(response.body);
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
}

List<ProjectResponse> projectFromJson(String json) {
  final parsedData = jsonDecode(json);
  List<ProjectResponse> projects = [];

  for (var projectData in parsedData['projects']) {
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
