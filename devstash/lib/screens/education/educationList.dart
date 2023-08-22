import 'dart:developer';

import 'package:devstash/models/response/education.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/education/educationEditScreen.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EducationList extends StatelessWidget {
  List<EducationResponse>? educationList;
  EducationList({super.key, required this.educationList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EducationEditProfileScreen(
                            title: "Add",
                            educationList: null,
                          )),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: educationList!.length,
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
                        educationList![index].collegeorSchoolName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        '${educationList![index].educationLevel} - ${educationList![index].subject}\n${educationList![index].fromYear} - ${educationList![index].toYear}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 165, 165, 165),
                        ),
                      ),
                      onTap: () => {
                        // _delete(educationList![index].id!)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EducationEditProfileScreen(
                                    title: "Edit",
                                    educationList: educationList![index],
                                  )),
                        )
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _delete(String id) async {
    try {
      final provider = AuthProvider();
      dynamic _user =
          await EducationServices().deleteEducation(provider.token, id);
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
