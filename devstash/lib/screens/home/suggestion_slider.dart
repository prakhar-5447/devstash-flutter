import 'package:devstash/models/response/user_state.dart';
import 'package:flutter/material.dart';

class SuggestionSlider extends StatelessWidget {
  final List<UserState> recommendedUsers = [
    UserState("0", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("2", "_name", 'assets/main_bg.jpeg', "_username", "_email",
        "_description"),
    UserState("2", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("3", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("4", "_name", 'assets/main_bg.jpeg', "_username", "_email",
        "_description"),
    UserState("5", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: recommendedUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 40,
              right: index == recommendedUsers.length - 1 ? 20 : 0,
              top: 10,
              bottom: 10,
            ),
            child: buildRecommendedUserCard(recommendedUsers[index]),
          );
        },
      ),
    );
  }
}

Widget buildRecommendedUserCard(UserState user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          user.avatar,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: 50,
        child: Center(
          child: Text(
            user.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
