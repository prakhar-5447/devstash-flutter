import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/projectDetailScreen.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:devstash/models/ProjectInfo.dart';
import 'package:flutter/material.dart';
import 'package:devstash/constants.dart';
import 'package:provider/provider.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    final List<ProjectInfo> project = [];
    late List<ProjectResponse>? projectData = [];
    int _selectedProjectIndex = -1;

    Future<List<ProjectInfo>> _getProject() async {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      String? token = auth.token;
      if (token != null) {
        projectData = await ProjectServices().getProjects(token);

        if (projectData != null) {
          for (var i = 0; i < projectData!.length; i++) {
            var currentProject = projectData!.elementAt(i);

            project.add(ProjectInfo(
              currentProject.id,
              currentProject.title,
              "${ApiConstants.baseUrl}/images/" + currentProject.image,
              currentProject.createdDate,
              currentProject.url,
              currentProject.description,
            ));
          }
        }
      }
      return project;
    }

    Future<void> _removeProject(int index) async {
      setState(() {
        project.removeAt(index);
        _selectedProjectIndex = -1;
      });
    }

    return Scaffold(
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Text("PROJECTS",
                    style: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: project.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = project[index];
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        _selectedProjectIndex = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color:
                                                _selectedProjectIndex == index
                                                    ? Colors.red
                                                    : const Color.fromARGB(
                                                        255, 174, 183, 254),
                                            width: 5.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: 150,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      item.image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 100,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ProjectDetailScreen(
                                                                        id: item
                                                                            .id)),
                                                          )
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/redirect.svg",
                                                          height: 25,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            item.name,
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      75,
                                                                      73,
                                                                      70),
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            item.date,
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      165,
                                                                      165,
                                                                      165),
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${item.description} ${item.id}",
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
