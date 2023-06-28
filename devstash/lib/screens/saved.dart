import 'package:devstash/models/Bookmarks.dart';
import 'package:devstash/models/ProjectList.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Favourites', 'Bookmarks'];
  final List<ProjectList> project = [
    ProjectList("assets/todo.png"),
    ProjectList("assets/firstmy.jpg")
  ];
  final List<Bookmarks> bookmark = [
    Bookmarks("PRATHAM SAHU", "assets/google.png"),
    Bookmarks("PRAKHAR SAHU", "assets/google.png"),
  ];

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
                  child: GridView.builder(
                    shrinkWrap:
                        true, // Allow the GridView to take only the necessary height
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
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
                              image: AssetImage(
                                project[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(11))),
                      );
                    },
                  ),
                ),
              ),
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
