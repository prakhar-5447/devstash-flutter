import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/CalendarScreen.dart';
import 'package:devstash/screens/home/home_screen.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:devstash/screens/auth/welcome_screen.dart';
import 'package:devstash/screens/saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final int currentIndex; // Add currentIndex property

  const AppDrawer({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

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
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selectedColor: Colors.white,
                    selectedTileColor: const Color.fromARGB(255, 174, 183, 254),
                    selected: widget.currentIndex == 0,
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = 0;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    leading: SvgPicture.asset(
                      'assets/home.svg',
                      height: 15.0,
                      width: 30.0,
                      color: widget.currentIndex == 0
                          ? Colors.white
                          : Colors.black,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selectedColor: Colors.white,
                    selectedTileColor: const Color.fromARGB(255, 174, 183, 254),
                    selected: widget.currentIndex == 1, //
                    leading: SvgPicture.asset(
                      'assets/profile.svg',
                      height: 15.0,
                      width: 30.0,
                      color: widget.currentIndex == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = 1;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selectedColor: Colors.white,
                    selectedTileColor: const Color.fromARGB(255, 174, 183, 254),
                    selected: widget.currentIndex == 2, //
                    leading: SvgPicture.asset(
                      'assets/bookmark.svg',
                      height: 15.0,
                      width: 30.0,
                      color: widget.currentIndex == 2
                          ? Colors.white
                          : Colors.black,
                    ),
                    title: const Text(
                      'Bookmark',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Saved()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    selectedColor: Colors.white,
                    selectedTileColor: const Color.fromARGB(255, 174, 183, 254),
                    selected: widget.currentIndex == 3, //
                    leading: SvgPicture.asset(
                      'assets/task.svg',
                      height: 15.0,
                      width: 30.0,
                      color: widget.currentIndex == 3
                          ? Colors.white
                          : Colors.black,
                    ),
                    title: const Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentScreenIndex = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarScreen(context)),
                      );
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
                      onPressed: () async {
                        authProvider.setToken(null);
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('token', '');
                        Get.off(() => WelcomeScreen());
                      },
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
