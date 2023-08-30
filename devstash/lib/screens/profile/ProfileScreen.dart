import 'dart:developer';
import 'package:devstash/models/ProjectList.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/screens/projects/projectDetailScreen.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:devstash/constants.dart';
import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/Project.dart';
import 'package:devstash/models/response/contactResponse.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:devstash/models/response/socialsResponse.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/screens/profile/EditProfile.dart';
import 'package:devstash/screens/contact/contactScreen.dart';
import 'package:devstash/screens/education/educationList.dart';
import 'package:devstash/screens/skills/skillList.dart';
import 'package:devstash/services/ContactServices.dart';
import 'package:devstash/services/Skillservices.dart';
import 'package:devstash/services/SocialServices.dart';
import 'package:devstash/services/avatarServices.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final UserState? user = userController.user;
    final date = DateTime.now();
    List<EducationResponse>? educations;
    SkillResponse? tech;
    ContactResponse? contactDetails;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 500,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                        image: const AssetImage(
                          "assets/banner.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 25,
                    child: SvgPicture.asset(
                      'assets/arrow.svg',
                      height: 15.0,
                      width: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Avatar(avatar: user?.avatar)
                ],
              ),
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                  },
                  child: Align(
                    alignment: const AlignmentDirectional(0.93, 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'PORTFOLIO',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            'assets/redirect.svg',
                            height: 10.0,
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user?.name ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          user?.username ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 165, 165, 165)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                          child: Text(
                            user?.description ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 165, 165, 165)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: FutureBuilder<SocialsResponse?>(
                          future: _getsocials(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(
                                width: 40,
                                child: CircularProgressIndicator(),
                              ); // Show loading indicator while waiting for data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              SocialsResponse? socials = snapshot.data;
                              if (socials == null) {
                                return const Text('No socials data found.');
                              }

                              final Map<String, dynamic> socialIcons = {
                                'twitter': socials.twitter,
                                'instagram': socials.instagram,
                                'linkedin': socials.linkedin,
                                'github': socials.github,
                              };

                              return SizedBox(
                                width: 250,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (var social in socialIcons.keys)
                                      GestureDetector(
                                        onTap: () async {
                                          final Uri url = Uri.parse(
                                              'https://${social}.com/${socialIcons[social]}');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('invalid url $url'),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Image.asset(
                                            'assets/google.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }
                          })),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Projects",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: FutureBuilder<List<ProjectList>?>(
                            future: _getprojects(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<ProjectList>? projects = snapshot.data;
                                if (projects == null) {
                                  return const Text('No projects data found.');
                                }

                                return GridView.builder(
                                  shrinkWrap:
                                      true, // Allow the GridView to take only the necessary height
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // Number of columns in the grid
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: projects.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () => Get.to(() =>
                                          ProjectDetailScreen(
                                              id: projects[index].id,
                                              onDelete: null,
                                              index: index)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.5),
                                                BlendMode.darken,
                                              ),
                                              image: NetworkImage(
                                                  projects[index].image),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Education",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EducationList(
                                        educationList: educations)),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<List<EducationResponse>?>(
                          future: _geteducations(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              educations = snapshot.data;
                              if (educations == null) {
                                return const Text('No socials data found.');
                              }

                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var i in educations!)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 241, 242, 246),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          i.collegeorSchoolName!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${i.educationLevel} - ${i.subject}\n${i.fromYear} - ${i.toYear}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 165, 165, 165),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Skills",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SkillList(
                                          skillList: tech,
                                        )),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      FutureBuilder<SkillResponse?>(
                          future: _getskills(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              tech = snapshot.data;
                              if (tech == null) {
                                return const Text('No skills data found.');
                              }
                              return GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 4,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: tech!.skills!
                                    .map(
                                      (item) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 5,
                                            height: 5,
                                            margin: const EdgeInsets.only(
                                                top: 6, right: 6),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 75, 73, 70),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              );
                            }
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Contact",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactScreen(
                                          contact: contactDetails,
                                        )),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ContactResponse?>(
                          future: _getcontact(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              contactDetails = snapshot.data;
                              if (contactDetails == null) {
                                return const Text('No contacts data found.');
                              }
                              return Container(
                                padding: const EdgeInsets.only(left: 20),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 241, 242, 246),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/navigator.svg',
                                            height: 15.0,
                                            width: 15.0,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${contactDetails!.city} , ${contactDetails!.state}, ${contactDetails!.country}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 75, 73, 70),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25, bottom: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/email.svg',
                                              height: 15.0,
                                              width: 15.0,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'sahuprakhar022003@gmail.com',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 75, 73, 70),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/phone.svg',
                                            height: 15.0,
                                            width: 15.0,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${contactDetails!.phoneNo}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 75, 73, 70),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<ProjectList>?> _getprojects(BuildContext context) async {
    List<ProjectList> projects = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await ProjectServices().getProjects(token);
      if (res['success']) {
        for (var project in res['data']) {
          projects.add(ProjectList(
              project.id, "${ApiConstants.baseUrl}/images/" + project.image));
        }
        return projects;
      }
      return null;
    }
  }

  Future<SocialsResponse?> _getsocials(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await SocialServices().getSocials(token);
      if (res['success']) {
        return res['data'];
      }
      return null;
    }
  }

  Future<List<EducationResponse>?> _geteducations(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final educationResponse = await EducationServices().getEducation(token);
        if (educationResponse != null) {
          return educationResponse;
        } else {
          log("Failed to get education data");
        }
      }
    } catch (error) {
      log("Error while fetching educating: $error");
    }
    return null;
  }

  Future<SkillResponse?> _getskills(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final skillResponse = await SkillServices().getskill(token);
        if (skillResponse != null) {
          return skillResponse;
        } else {
          log("Failed to get skill data");
        }
      }
    } catch (error) {
      log("Error while fetching educating: $error");
    }
    return null;
  }

  Future<ContactResponse?> _getcontact(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final contact = await ContactServices().getContact(token);
        if (contact != null) {
          return contact;
        } else {
          log("Failed to get contact data");
        }
      }
    } catch (error) {
      log("Error while fetching educating: $error");
    }
    return null;
  }
}

class Avatar extends StatefulWidget {
  String? avatar;
  Avatar({super.key, required this.avatar});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late XFile _pickedImage = XFile('');
  bool _isLoading = false;
  Future<void> _pickImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
      await _uploadImage(token);
    }
  }

  Future<void> _uploadImage(String? token) async {
    if (_pickedImage.path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image first'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueAccent,
        ),
      );
      return;
    }
    dynamic res = await AvatarServices().updateAvatar(token, _pickedImage);
    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res['msg']),
          behavior: SnackBarBehavior.floating,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(0, 75),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
            ),
            child: Align(
              alignment: const AlignmentDirectional(-0.01, 2.25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: widget.avatar != null
                    ? Image.network(
                        "${ApiConstants.baseUrl}/images/${widget.avatar}",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
