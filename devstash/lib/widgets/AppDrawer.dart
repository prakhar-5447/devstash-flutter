import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          top: 75,
          right: 25,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: const Text(
                'DevStash',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, bottom: 20),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      // side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selectedColor: Colors.white,
                    selectedTileColor: const Color.fromARGB(255, 174, 183, 254),
                    selected: _currentScreenIndex ==
                        0, // Set the selected state based on the current screen index
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = 0;
                      });
                      Navigator.pop(context);
                    },
                    leading: SvgPicture.asset(
                      'assets/home.svg',
                      height: 15.0,
                      width: 30.0,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                        color: Color.fromARGB(255, 75, 73, 70),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/profile.svg',
                      height: 15.0,
                      width: 30.0,
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                        color: Color.fromARGB(255, 75, 73, 70),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/bookmark.svg',
                      height: 15.0,
                      width: 30.0,
                    ),
                    title: const Text(
                      'Bookmark',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                        color: Color.fromARGB(255, 75, 73, 70),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/task.svg',
                      height: 15.0,
                      width: 30.0,
                    ),
                    title: const Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                        color: Color.fromARGB(255, 75, 73, 70),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: SizedBox(
                      height: 1,
                      child: Container(
                        color: Colors.black,
                        width: 150,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 25, right: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Log out",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SvgPicture.asset(
                            'assets/logout.svg',
                            height: 15.0,
                            width: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
