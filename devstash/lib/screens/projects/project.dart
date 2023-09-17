import 'dart:developer';

import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/screens/projects/ProjectAddScreen.dart';
import 'package:devstash/screens/projects/ProjectEditScreen.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/models/ProjectInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:devstash/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  final List<ProjectInfo> project = [];
  bool isDataLoaded = false;
  late List<ProjectResponse>? projectData = [];
  int _selectedProjectIndex = -1;

  Future<List<ProjectInfo>> _getProject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && !isDataLoaded) {
      dynamic res = await ProjectServices().getProjects(token);
      if (res["success"]) {
        projectData = res['data'];
        if (projectData != null) {
          for (var i = 0; i < projectData!.length; i++) {
            var currentProject = projectData!.elementAt(i);
            String dateString = currentProject.createdDate;
            DateTime dateTime = DateTime.parse(dateString);
            String formattedDate = DateFormat.yMMMMd().format(dateTime);
            project.add(ProjectInfo(
              currentProject.id,
              currentProject.title,
              "${ApiConstants.baseUrl}/images/${currentProject.image}",
              formattedDate,
              currentProject.url,
              currentProject.description,
            ));
          }
        }
      }
      setState(() {
        isDataLoaded = true;
      });
    }
    return project;
  }

  void _addProject(ProjectResponse projectResponse) {
    String dateString = projectResponse.createdDate;
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMMd().format(dateTime);

    ProjectInfo newProject = ProjectInfo(
      projectResponse.id,
      projectResponse.title,
      "${ApiConstants.baseUrl}/images/${projectResponse.image}",
      formattedDate,
      projectResponse.url,
      projectResponse.description,
    );

    setState(() {
      project.add(newProject);
    });
  }

  Future<void> _removeProject(String id, int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await ProjectServices().deleteProject(token, id);
      if (res["success"]) {
        setState(() {
          project.removeAt(index);
          _selectedProjectIndex = -1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProjectAddScreen(addProject: _addProject));
            },
            icon: const Icon(
              Icons.add,
              size: 12,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: FutureBuilder<void>(
                  future: _getProject(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: project.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = project[index];
                              return Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            item.description.length <= 100
                                                ? item.description
                                                : '${item.description.substring(0, 100)}...',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        enableFeedback: false,
                                        color: Colors.black,
                                        splashColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Get.to(() =>
                                              ProjectEditScreen(id: item.id));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.black26,
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
