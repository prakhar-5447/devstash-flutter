import 'dart:ui';
import "dart:developer";
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/screens/projects/FavoriteButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:flutter/material.dart';
import 'package:devstash/constants.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String id;
  final dynamic onDelete;
  final int index;
  const ProjectDetailScreen(
      {super.key,
      required this.id,
      required this.onDelete,
      required this.index});

  @override
  Widget build(BuildContext context) {
    late List<CollaboratorResponse> collaboratorUsersDetail = [];
    bool found = false;

    Future<ProjectResponse?> _getProjectDetail() async {
      ProjectResponse projectDetail =
          ProjectResponse("", "", "", "", "", "", "", [], [], "", []);
      dynamic res = await ProjectServices().getProjectById(id);
      if (res['success']) {
        ProjectResponse projectData = res["data"];
        if (projectData != null) {
          String dateString = projectData.createdDate;
          DateTime dateTime = DateTime.parse(dateString);
          String formattedDate = DateFormat.yMMMd().format(dateTime);

          projectDetail = ProjectResponse(
              projectData.userID,
              projectData.id,
              formattedDate,
              "${ApiConstants.baseUrl}/images/${projectData.image}",
              projectData.title,
              projectData.url,
              projectData.description,
              projectData.technologies,
              projectData.collaboratorsID,
              projectData.projectType,
              projectData.hashtags);
        }

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          dynamic res =
              await FavoriteServices().checkFavorite(token, projectDetail.id);
          if (res['success']) {
            log(res.toString());
            found = res['data'];
          }
        }

        if (projectDetail.collaboratorsID.isNotEmpty) {
          dynamic res = await ProjectServices()
              .getCollaboratorUsers(projectDetail.collaboratorsID);
          if (res['success']) {
            collaboratorUsersDetail = res['data'];
          }
        }
        return projectDetail;
      }
      return null;
    }

    ProjectResponse? projectDetail;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<ProjectResponse?>(
          future: _getProjectDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              projectDetail = snapshot.data;
              if (projectDetail == null) {
                Navigator.pop(context);
              }
              if (projectDetail != null) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 20,
                        child: FavoriteButton(
                          id: '64edf26b5fc25c49bc36c69d',
                          found: found,
                          index: index,
                          onDelete: onDelete,
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        projectDetail!.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      // final Uri url =
                                      //     Uri.parse(projectDetail!.url);
                                      // if (await canLaunchUrl(url)) {
                                      //   await launchUrl(url);
                                      // } else {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(
                                      //     SnackBar(
                                      //       content: Text('invalid url $url'),
                                      //       behavior: SnackBarBehavior.floating,
                                      //       backgroundColor: Colors.red,
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child: Text(
                                      projectDetail!.title.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    projectDetail!.createdDate,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              projectDetail!.description,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: projectDetail!.technologies.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color.fromARGB(
                                        255, 232, 231, 255),
                                  ),
                                  child: Text(
                                    tech,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "collaborators: ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: collaboratorUsersDetail.map((item) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: const BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 241, 242, 246)),
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 39, 24, 126),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }
          }),
    );
  }
}
