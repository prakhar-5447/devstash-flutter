import 'dart:developer';
import 'package:devstash/models/ProjectList.dart';
import 'package:devstash/screens/projects/project.dart';
import 'package:devstash/screens/projects/projectDetailScreen.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:devstash/constants.dart';
import 'package:devstash/controllers/user_controller.dart';
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
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
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
                  SafeArea(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://prakhar-5447.github.io/angular-portfolio');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('invalid url $url'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Align(
                            alignment: Alignment.topRight,
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
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'assets/redirect.svg',
                                    height: 10.0,
                                    width: 10.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Avatar(avatar: user?.avatar),
                ],
              ),
            ),
            const Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(
                              "12",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "20",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        user?.username ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(
                            255,
                            165,
                            165,
                            165,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        user?.description ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<SocialsResponse?>(
                    future: _getsocials(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 40,
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        SocialsResponse? socials = snapshot.data;
                        if (socials == null) {
                          return const SizedBox();
                        }
                        final Map<String, dynamic> socialIcons = {
                          'twitter': socials.twitter,
                          'instagram': socials.instagram,
                          'linkedin': socials.linkedin,
                          'github': socials.github,
                        };
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var social in socialIcons.keys)
                              GestureDetector(
                                onTap: () async {
                                  final Uri url = Uri.parse(
                                      'https://$social.com/${socialIcons[social]}');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('invalid url $url'),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: socialIcons.keys
                                                .toList()
                                                .indexOf(social) <
                                            socialIcons.length - 1
                                        ? 10
                                        : 0,
                                  ),
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.asset(
                                    'assets/$social.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Project());
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Projects",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.black26,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<ProjectList>?>(
                        future: _getprojects(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<ProjectList>? projects = snapshot.data;
                            if (projects == null) {
                              return const Text('No projects data found.');
                            }
                            log(projects.toString());
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              padding: EdgeInsets.zero,
                              itemCount: projects.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () => Get.to(
                                    () => ProjectDetailScreen(
                                      id: projects[index].id,
                                      onDelete: null,
                                      index: index,
                                    ),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(
                                      0,
                                    ),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          projects[index].image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => EducationList(
                              educationList: educations,
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Education",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.black26,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<EducationResponse>?>(
                          future: _geteducations(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
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
                                      margin: const EdgeInsets.only(bottom: 10),
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
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SkillList(
                              skillList: tech,
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Skills",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.black26,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<SkillResponse?>(
                          future: _getskills(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
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
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ContactScreen(
                              contact: contactDetails,
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Contact",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.black26,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<ContactResponse?>(
                          future: _getcontact(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
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
                                              '${contactDetails!.city}, ${contactDetails!.state}, ${contactDetails!.country}',
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
      log(res['msg']);
      return null;
    }
  }

  Future<List<EducationResponse>?> _geteducations(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await EducationServices().getEducation(token);
      if (res['success']) {
        return res['data'];
      }
      return null;
    }
  }

  Future<SkillResponse?> _getskills(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await SkillServices().getskill(token);
      if (res['success']) {
        return res['data'];
      }
      return null;
    }
  }

  Future<ContactResponse?> _getcontact(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await ContactServices().getContact(token);
      if (res['success']) {
        return res['data'];
      }
      return null;
    }
  }
}

class Avatar extends StatelessWidget {
  final String? avatar;

  Avatar({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage(context);
      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Transform.translate(
          offset: const Offset(20, 60),
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: avatar != null
                      ? Image.network(
                          "${ApiConstants.baseUrl}/images/$avatar",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final _pickedImage = XFile(pickedImage.path);
      await _uploadImage(context, token, _pickedImage);
    }
  }

  Future<void> _uploadImage(
      BuildContext context, String? token, XFile pickedImage) async {
    if (pickedImage.path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image first'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueAccent,
        ),
      );
      return;
    }
    dynamic res = await AvatarServices().updateAvatar(token, pickedImage);
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
}
