import 'dart:developer';

import 'package:devstash/constants.dart';
import 'package:devstash/controllers/tabs_controller.dart';
import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/screens/home/home_screen.dart';
import 'package:devstash/screens/projects/project.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BindingScreen extends StatelessWidget {
  final BottomTabController tabController = Get.find<BottomTabController>();
  final PageStorageBucket bucket = PageStorageBucket();
  final UserController userController = Get.find<UserController>();
  final _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const Project(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: Obx(
          () => _pages[tabController.currentIndex.value],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNavButton(
                    context,
                    Icons.dashboard_rounded,
                    Icons.dashboard_outlined,
                    0,
                  ),
                  buildNavButton(
                    context,
                    Icons.supervisor_account,
                    Icons.supervisor_account_rounded,
                    1,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => MaterialButton(
                      enableFeedback: false,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      minWidth: 20,
                      onPressed: () {
                        tabController.changeTabIndex(2);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(
                                tabController.currentIndex.value == 2 ? 0 : 0.5,
                              ),
                              BlendMode.srcATop,
                            ),
                            child: CircleAvatar(
                              radius: 15,
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                "${ApiConstants.baseUrl}/images/${userController.user!.avatar}",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: 2 == tabController.currentIndex.value
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                            ),
                            width: 5,
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildNavButton(
                    context,
                    Icons.event_sharp,
                    Icons.event_sharp,
                    3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavButton(
      BuildContext context, IconData icon1, IconData icon2, int index) {
    return Obx(
      () => MaterialButton(
        enableFeedback: false,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        minWidth: 20,
        onPressed: () {
          tabController.changeTabIndex(index);
          log(index.toString());
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              index == tabController.currentIndex.value ? icon1 : icon2,
              size: 25,
              color: index == tabController.currentIndex.value
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == tabController.currentIndex.value
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              width: 5,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
