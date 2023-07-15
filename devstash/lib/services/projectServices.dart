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
            'v2.local.tN3JYuKCqQgZTQuTEAYTzcI58bOb23EO5MdIMZPbO6IWDjGbr93tnFWBkKtB95BbAEycczByqEhJB8VLj13cVs44tlKF6Km1c_DzMkSjtXc_bKY_Wysh7rbPh87eHpDR-WheHigRLHS89OGmGReGcohUIdlgRu1SduSu15ZD-Xnr-TzM_m-P8CI7ahQYaY1bJDShaG8W9sU0lpYoLi_-q0L1-4arnGMdiWEDdHZ8l-euU4QMbpf-QCrzvoMbxlkj6Cx2n2qQ3Z-_8Bp3ee1zz_15mw4OZ4dscKGkJrSxBlJuHDmysdGrz2Qp1m5k9czt.bnVsbA',
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
