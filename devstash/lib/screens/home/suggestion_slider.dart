import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/response/user_recommended.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/services/recommendationServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionSlider extends StatelessWidget {
  Future<List<RecommendedUser>?> _getUserRecommendation() async {
    late List<RecommendedUser> recommendedUsers;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      dynamic res =
          await RecomendationServices().getUserRecommendation(token, '1');
      if (res['success']) {
        recommendedUsers = res['data'];
      } else {
        Fluttertoast.showToast(
          msg: res['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return null;
      }
      return recommendedUsers;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecommendedUser>?>(
        future: _getUserRecommendation(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecommendedUser>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<RecommendedUser>? recommendedUsers = snapshot.data;
            if (recommendedUsers == null) {
              return const Text('Not able to fetch data');
            }
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
        });
  }
}

Widget buildRecommendedUserCard(RecommendedUser user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          "${ApiConstants.baseUrl}/images/${user.avatar}",
          fit: BoxFit.cover,
          width: 30,
          height: 30,
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: 40,
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
