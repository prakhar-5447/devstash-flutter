import "dart:developer";
import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/screens/projects/FavoriteButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:devstash/models/Collaborator.dart';
import 'package:devstash/models/Hashtag.dart';
import 'package:devstash/models/TechStack.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:flutter/material.dart';
import 'package:devstash/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            found = res['data'];
          }
        }

        if (projectDetail.collaboratorsID != null) {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: FavoriteButton(
          id: '64edf26b5fc25c49bc36c69d',
          found: found,
          index: index,
          onDelete: onDelete,
        ),
      ),
      appBar: AppBar(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(projectDetail!.image),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            projectDetail!.title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 75, 73, 70),
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final Uri githubRepoUri =
                                  Uri.parse(projectDetail!.url);
                              if (await canLaunchUrl(githubRepoUri)) {
                                await launchUrl(githubRepoUri);
                              } else {
                                throw 'Could not launch $githubRepoUri';
                              }
                            },
                            child: const Icon(
                              Icons.link,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        projectDetail!.createdDate,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 165, 165, 165),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        projectDetail!.description,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            height: 1.5),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: projectDetail!.technologies.map((tech) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      tech,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text("COLLABORATORS",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 165, 165, 165),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children:
                                            collaboratorUsersDetail.map((item) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 241, 242, 246)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(item.name,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 39, 24, 126),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12)),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: projectDetail!.hashtags.map((hash) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: Color.fromARGB(
                                                255, 39, 24, 126)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          child: Text("#$hash",
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 242, 246),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )),
                          ))
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
