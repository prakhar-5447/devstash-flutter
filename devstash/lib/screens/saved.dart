import 'dart:developer';
import 'package:devstash/models/Bookmarks.dart';
import 'package:devstash/models/ProjectList.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Favourites', 'Bookmarks'];
  final List<Bookmarks> bookmark = [
    Bookmarks("PRATHAM SAHU", "assets/google.png"),
    Bookmarks("PRAKHAR SAHU", "assets/google.png"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late FavoriteResponse? favoriteData;
  late ProjectResponse? projectData;

  Future<List<ProjectList>> _getData() async {
    final List<ProjectList> project = [];

    favoriteData = await FavoriteServices().getFavorite();

    for (var i = 0; i < favoriteData!.projectLength; i++) {
      projectData =
          await ProjectServices().getProjectById(favoriteData!.projectIds[i]);
      project.add(ProjectList(projectData!.image));
    }

    return project;
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
                child: FutureBuilder<List<ProjectList>>(
                  future: _getData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProjectList>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                        children: snapshot.data!.map((projectList) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                  const Color.fromARGB(255, 165, 165, 165)
                                      .withOpacity(0.25),
                                  BlendMode.darken,
                                ),
                                image: NetworkImage('http://192.168.1.113:8080/images/'+projectList.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(11)),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                  child: ListView.builder(
                      itemCount: bookmark.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(
                                        bookmark[index].avatar,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(bookmark[index].name,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 75, 73, 70),
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
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
                                                      color: Color.fromARGB(255,
                                                          117, 140, 253)))),
                                          backgroundColor:
                                              const MaterialStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      255, 117, 140, 253))),
                                      onPressed: () => {},
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 234, 228, 228),
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      )),
                                ),
                              ]),
                        );
                      })),
            ],
          ),
        ),
      ),
    ]));
  }
}
