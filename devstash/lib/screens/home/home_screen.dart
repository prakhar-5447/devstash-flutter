import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/widgets/AppDrawer.dart';
import 'package:devstash/screens/tasks/WeekdayTaskScreen.dart';
import 'package:devstash/screens/home/suggestion_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final UserState? user = userController.user;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 250),
      drawer: AppDrawer(
        currentIndex: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 130, 129, 129),
                        ),
                      ),
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "0 notifications, 0 messages",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 159, 157, 157),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 217, 217, 217),
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Find someone simmilar to you...",
                            suffixIcon: const Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          "Suggestions for you",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SuggestionSlider(),
                    ],
                  ),
                ),
                WeekdayTaskScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
