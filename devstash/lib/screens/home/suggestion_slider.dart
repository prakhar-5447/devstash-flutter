import 'package:devstash/models/response/user_state.dart';
import 'package:flutter/material.dart';

class SuggestionSlider extends StatelessWidget {
  final List<UserState> recommendedUsers = [
    UserState("0", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("1", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("2", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("3", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("4", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
    UserState("5", "_name", 'assets/banner.jpg', "_username", "_email",
        "_description"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: recommendedUsers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
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
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 217, 217, 217),
          blurRadius: 3,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.asset(
            user.avatar,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          user.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Connect'),
        ),
      ],
    ),
  );
}
