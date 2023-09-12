import 'dart:developer';

import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/skills/SkillEditScreen.dart';
import 'package:devstash/services/SkillServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillList extends StatelessWidget {
  SkillResponse? skillList;
  SkillList({super.key, required this.skillList}) {
    skillList ??= SkillResponse(skills: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SkillEditScreen()),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: skillList!.skills!.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 242, 246),
                    ),
                    child: ListTile(
                      title: Text(
                        skillList!.skills![index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () => {_delete(skillList!.skills![index])},
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _delete(String skill) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        SkillRequest _skill = SkillRequest(skill: skill);
        dynamic res = await SkillServices().deleteskill(token, _skill);
        Fluttertoast.showToast(
          msg: res['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
