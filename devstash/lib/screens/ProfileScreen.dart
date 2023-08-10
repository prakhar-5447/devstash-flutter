import 'dart:developer';

import 'package:devstash/models/Project.dart';
import 'package:devstash/models/response/contactResponse.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:devstash/models/response/socialsResponse.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/EditProfile.dart';
import 'package:devstash/screens/SkillEditScreen.dart';
import 'package:devstash/screens/contactScreen.dart';
import 'package:devstash/screens/educationEditScreen.dart';
import 'package:devstash/screens/educationList.dart';
import 'package:devstash/screens/skillList.dart';
import 'package:devstash/services/ContactServices.dart';
import 'package:devstash/services/Skillservices.dart';
import 'package:devstash/services/SocialServices.dart';
import 'package:devstash/services/avatarServices.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    UserState? user = authProvider.user;
    final date = DateTime.now();
    List<EducationResponse>? educations;
    SkillResponse? tech;
    ContactResponse? contactDetails;

    List<Project> projects = [
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      ),
      Project(
        "Juicy-N-Yummy",
        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.",
        date,
        "https://github.com/pratham-0094",
        "banner.jpg",
        ["html", "css", "javascript"],
        ["prakhar-5447", "pratham-0094"],
        ["angular", "web"],
      )
    ];

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
                  Avatar()
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
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
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
                      child: SizedBox(
                    width: 250,
                    child: FutureBuilder<SocialsResponse?>(
                        future: _getsocials(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            SocialsResponse? socials = snapshot.data;
                            if (socials == null) {
                              return Text('No socials data found.');
                            }

                            // Define the social icons and their respective asset paths
                            final Map<String, String> socialIcons = {
                              'twitter':
                                  'assets/linkedin.png', // Replace with the correct asset for Twitter
                              'instagram':
                                  'assets/google.png', // Replace with the correct asset for Instagram
                              'linkedin':
                                  'assets/google.png', // Replace with the correct asset for LinkedIn
                              'github':
                                  'assets/linkedin.png', // Replace with the correct asset for GitHub
                            };

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var social in socialIcons.keys)
                                  Container(
                                    width: 45,
                                    height: 45,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Image.asset(
                                      socialIcons[social] ??
                                          'assets/google.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                              ],
                            );
                          }
                        }),
                  )),
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
                        child: GridView.builder(
                          shrinkWrap:
                              true, // Allow the GridView to take only the necessary height
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns in the grid
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: projects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                            );
                          },
                        ),
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

  Future<SocialsResponse?> _getsocials(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

      if (token != null) {
        // Call the API to get socials data
        final socialsResponse = await SocialServices().getSocials(token);

        // Check if the API call was successful
        if (socialsResponse != null) {
          // Socials data received successfully
          print("Socials data: ${socialsResponse.twitter}");
          return socialsResponse;
          // You can log the socials data here or handle it as per your requirement
        } else {
          // API call failed or no socials data received
          print("Failed to get socials data");
        }
      }
    } catch (error) {
      // Handle any errors that may occur during the API call
      print("Error while fetching socials: $error");
    }
    return null;
  }

  Future<List<EducationResponse>?> _geteducations(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? token = authProvider.token;

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
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late XFile _pickedImage = XFile('');
  bool _isLoading = false;
  Future<void> _pickImage(String? token) async {
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
    dynamic data = await AvatarServices().updateAvatar(token, _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        _pickImage(provider.token);
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
                child: Image.network(
                  'https://avatars.githubusercontent.com/u/80202909?s=400&u=eb9dc715363d2d16941b2a809567e7fb685a9a16&v=4',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
