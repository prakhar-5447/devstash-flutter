import 'dart:developer';
import 'package:devstash/models/Bookmarks.dart';
import 'package:devstash/models/ProjectList.dart';
import 'package:devstash/models/response/bookmarkResponse.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/models/response/userResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/bookmarkServices.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:devstash/constants.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Favourites', 'Bookmarks'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late FavoriteResponse? favoriteData;
  late BookmarkResponse? bookmarkData;

  final List<ProjectList> project = [];
  final List<Bookmarks> bookmark = [];

  Future<List<ProjectList>> _getfavorite() async {
    late ProjectResponse? projectData;

    final auth = Provider.of<AuthProvider>(context, listen: false);
    String? token = auth.token;
    if (token != null) {
      favoriteData = await FavoriteServices().getFavorite(token);

      if (favoriteData?.projectLength != null &&
          favoriteData!.projectLength > 0) {
        for (var i = 0; i < favoriteData!.projectLength; i++) {
          projectData = await ProjectServices()
              .getProjectById(favoriteData!.projectIds[i]);
          if (projectData != null) {
            project.add(ProjectList(
                "${ApiConstants.baseUrl}/images/" + projectData.image));
          }
        }
      }
    }
    return project;
  }

  Future<List<Bookmarks>> _bookmarkData() async {
    late UserResponse? userData;

    final auth = Provider.of<AuthProvider>(context, listen: false);
    String? token = auth.token;
    if (token != null) {
      bookmarkData = await BookmarkServices().getBookmark(token);

      if (bookmarkData?.userLength != null && bookmarkData!.userLength > 0) {
        for (var i = 0; i < bookmarkData!.userLength; i++) {
          userData =
              await UserServices().getUserById(bookmarkData!.otherUserIds[i]);
          if (userData != null) {
            bookmark.add(Bookmarks(userData.name,
                "${ApiConstants.baseUrl}/images/" + userData.avatar));
          }
        }
      }
    }
    return bookmark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          decoration: const BoxDecoration(
            color: Colors.white,
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
                Text("FAVOURITES",
                    style: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ],
            ),
          )),
      Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            tabs: _tabs
                .map((String tab) => Tab(
                      child: Text(tab,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 75, 73, 70),
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                    ))
                .toList(),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 117, 140, 253),
                width: 3,
              ),
              insets: EdgeInsets.symmetric(horizontal: 120),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                child: FutureBuilder<void>(
                  future: _getfavorite(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                        ),
                        itemCount: project.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(11)),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                  child: FutureBuilder<void>(
                      future: _bookmarkData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                            itemCount: bookmark.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            bookmark[index].name,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 75, 73, 70),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
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
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 117, 140, 253),
                                          ),
                                        ),
                                        onPressed: () => {},
                                        child: const Text(
                                          "Remove",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 234, 228, 228),
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w300,
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
                      }))
            ],
          ),
        ),
      ),
    ]));
  }
}
