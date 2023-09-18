import 'dart:developer';
import 'package:devstash/controllers/network_controller.dart';
import 'package:devstash/models/Bookmarks.dart';
import 'package:devstash/models/ProjectList.dart';
import 'package:devstash/models/response/bookmarkResponse.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/screens/projects/projectDetailScreen.dart';
import 'package:devstash/services/bookmarkServices.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:devstash/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNetworks extends StatelessWidget {
  final _tabController = Get.put(NetworkController());
  final List<String> _tabs = ['Followers', 'Following', 'Bookmarks'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            child: Obx(
              () => TabBar(
                controller: _tabController.networktabController,
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(
                  0,
                ),
                dividerColor: Colors.transparent,
                tabs: _tabs
                    .map((String tab) => Tab(
                          child: Text(
                            tab,
                            style: TextStyle(
                              color: _tabController.selectedTabIndex.value ==
                                      _tabs.indexOf(tab)
                                  ? Colors.black
                                  : Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          ),
                        ))
                    .toList(),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 117, 140, 253),
                    width: 2,
                  ),
                  insets: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: TabBarView(
                controller: _tabController.networktabController,
                children: [
                  FollowersTab(),
                  FollowersTab(),
                  BookmarkTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookmarkTab extends StatelessWidget {
  final List<ProjectList> project = [];
  late FavoriteResponse? favoriteData;

  Future<List<ProjectList>> _getfavorite() async {
    late ProjectResponse? projectData;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      dynamic res = await FavoriteServices().getFavorite(token);
      if (res['success']) {
        favoriteData = res['data'];
        if (favoriteData?.projectLength != null &&
            favoriteData!.projectLength > 0) {
          int errCount = 0;
          for (var i = 0; i < favoriteData!.projectLength; i++) {
            dynamic res = await ProjectServices()
                .getProjectById(favoriteData!.projectIds[i]);
            if (res['success']) {
              projectData = res["data"];
              if (projectData != null) {
                project.add(ProjectList(projectData.id,
                    "${ApiConstants.baseUrl}/images/" + projectData.image));
              }
            } else {
              errCount = errCount + 1;
            }
          }
          if (errCount > 0) {
            Fluttertoast.showToast(
              msg: "Unexpected error occur",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: res["success"] ? Colors.green : Colors.red,
              textColor: Colors.white,
            );
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
      }
    }
    return project;
  }

  void onDelete(int indexToDelete) {
    if (indexToDelete >= 0 && indexToDelete < project.length) {
      log('Item at index $indexToDelete has been deleted.');
    } else {
      log('Invalid index: $indexToDelete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _getfavorite(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: project.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  Get.to(() => ProjectDetailScreen(
                        id: project[index].id,
                        onDelete: onDelete,
                        index: index,
                      ))
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        const Color.fromARGB(255, 165, 165, 165)
                            .withOpacity(0.25),
                        BlendMode.darken,
                      ),
                      image: NetworkImage(project[index].image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class FollowersTab extends StatelessWidget {
  late BookmarkResponse? bookmarkData;
  bool isBookmarkDataLoaded = false;

  final List<Bookmarks> bookmark = [];

  Future<List<Bookmarks>> _bookmarkData() async {
    late UserState? userData;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && !isBookmarkDataLoaded) {
      dynamic res = await BookmarkServices().getBookmark(token);
      if (res['success']) {
        bookmarkData = res['data'];
        if (bookmarkData?.userLength != null && bookmarkData!.userLength > 0) {
          int errCount = 0;
          for (var i = 0; i < bookmarkData!.userLength; i++) {
            dynamic res =
                await UserServices().getUserById(bookmarkData!.otherUserIds[i]);
            if (res['success']) {
              userData = res["data"];
              if (userData != null) {
                bookmark.add(Bookmarks(userData.name,
                    "${ApiConstants.baseUrl}/images/" + userData.avatar));
              }
            } else {
              errCount = errCount + 1;
            }
          }
          if (errCount > 0) {
            Fluttertoast.showToast(
              msg: "Unexpected error occur",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: res["success"] ? Colors.green : Colors.red,
              textColor: Colors.white,
            );
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
      }
    }
    return bookmark;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _bookmarkData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            itemCount: bookmark.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              bookmark[index].avatar,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          bookmark[index].name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 75, 73, 70),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 117, 140, 253),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 117, 140, 253),
                          ),
                        ),
                        onPressed: () => {},
                        child: const Text(
                          "Remove",
                          style: TextStyle(
                            color: Color.fromARGB(255, 234, 228, 228),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
