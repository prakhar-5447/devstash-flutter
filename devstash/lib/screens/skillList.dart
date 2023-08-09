import 'dart:developer';

import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/SkillEditScreen.dart';
import 'package:devstash/screens/educationEditScreen.dart';
import 'package:devstash/services/SkillServices.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SkillList extends StatelessWidget {
  SkillResponse? skillList;
  SkillList({super.key, required this.skillList});

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AuthProvider>(context);

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
                      onTap: () =>
                          {_delete(skillList!.skills![index], _provider.token)},
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _delete(String skill, String? token) async {
    try {
      log(skill);
      SkillRequest _skill = SkillRequest(skill: skill);
      dynamic _user = await SkillServices().deleteskill(token, _skill);
      log(_user.toString());
      Fluttertoast.showToast(
        msg: "Successfully Save Details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (error) {
      log(error.toString());
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
