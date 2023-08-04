import "dart:developer";
import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/widgets/FavoriteButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:devstash/models/Collaborator.dart';
import 'package:devstash/models/Hashtag.dart';
import 'package:devstash/models/TechStack.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:devstash/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String id;
  const ProjectDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    late ProjectResponse projectDetail =
        ProjectResponse('', '', '', '', '', '', '', [], [], '', []);
    late List<CollaboratorResponse> collaboratorUsersDetail = [];
    bool found = false;

    Future<void> _getProjectDetail() async {
      late ProjectResponse? projectData;
      projectData = await ProjectServices().getProjectById(id);

      if (projectData != null) {
        String dateString = projectData.createdDate;
        DateTime dateTime = DateTime.parse(dateString);
        String formattedDate = DateFormat.yMMMMd().format(dateTime);

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
      final auth = Provider.of<AuthProvider>(context, listen: false);
      String? token = auth.token;
      if (token != null) {
        found = await FavoriteServices().checkFavorite(token, projectDetail.id);
      }

      late List<CollaboratorResponse>? collaboratorData;
      if (projectDetail.collaboratorsID.isNotEmpty) {
        collaboratorData = await ProjectServices()
            .getCollaboratorUsers(projectDetail.collaboratorsID);
        if (collaboratorData != null) {
          collaboratorUsersDetail = collaboratorData;
        }
      }
    }


    return Scaffold(
      body: FutureBuilder<void>(
          future: _getProjectDetail(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Stack(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(57, 174, 183, 254),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 380,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50)),
                                      image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.dstATop),
                                        image:
                                            NetworkImage(projectDetail.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 4,
                                        sigmaY: 4,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25,
                                            right: 25,
                                            top: 40,
                                            bottom: 20),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Align(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Image.network(
                                                  projectDetail.image,
                                                  height: 200,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(projectDetail.title,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 75, 73, 70),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20)),
                                            Text(projectDetail.createdDate,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 117, 140, 253),
                                                ),
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(
                                              Color.fromARGB(
                                                  255, 117, 140, 253),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final Uri githubRepoUri =
                                                Uri.parse(projectDetail.url);
                                            if (await canLaunchUrl(
                                                githubRepoUri)) {
                                              await launchUrl(githubRepoUri);
                                            } else {
                                              throw 'Could not launch $githubRepoUri';
                                            }
                                          },
                                          child: const Text(
                                            "View Code",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 234, 228, 228),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: projectDetail.description),
                                      ],
                                      style: const TextStyle(
                                          height: 1.3,
                                          color: Color.fromARGB(
                                              255, 165, 165, 165),
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: SvgPicture.asset(
                                                "assets/tech-stack.svg",
                                                height: 30,
                                              ),
                                            ),
                                            const Text("TECH STACK",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20)),
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: projectDetail
                                                        .technologies
                                                        .map((tech) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 30),
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: Colors.white,
                                                          ),
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                              "${ApiConstants.baseUrl}/images/$tech.jpg",
                                                              fit: BoxFit
                                                                  .contain,
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
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text("COLLABORATORS",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20)),
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children:
                                                        collaboratorUsersDetail
                                                            .map((item) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          241,
                                                                          242,
                                                                          246)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child:
                                                                      ClipOval(
                                                                    child: Image
                                                                        .network(
                                                                      "${ApiConstants.baseUrl}/images/${item.avatar}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child: Text(
                                                                      item.name,
                                                                      style: const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              39,
                                                                              24,
                                                                              126),
                                                                          fontFamily:
                                                                              'Comfortaa',
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              12)),
                                                                ),
                                                              ],
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
                                              children: projectDetail.hashtags
                                                  .map((hash) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            3)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    39,
                                                                    24,
                                                                    126)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 15),
                                                      child: Text("#$hash",
                                                          style: const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      241,
                                                                      242,
                                                                      246),
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12)),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )),
                                      )),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 25,
                    right: 25,
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                        ),
                        child: FavoriteButton(
                          id: projectDetail.id,
                          found: found,
                        )),
                  ),
                ],
              );
            }
          }),
    );
  }

  void setState(Null Function() param0) {}
}
