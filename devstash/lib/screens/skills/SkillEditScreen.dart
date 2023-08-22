import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/SkillServices.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SkillEditScreen extends StatefulWidget {
  @override
  _SkillEditScreenState createState() => _SkillEditScreenState();
}

class _SkillEditScreenState extends State<SkillEditScreen> {
  final List<String> _skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'React',
    'JavaScript',
    'Python',
    'Java',
    'Swift',
    'C++',
  ];
  late String _selectedSkills = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8.0,
              children: _buildSkillChips(),
            ),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSkillChips() {
    return _skills.map((skill) {
      return ChoiceChip(
        label: Text(skill),
        selected: _selectedSkills.contains(skill),
        onSelected: (selected) {
          setState(() {
            _selectedSkills = skill;
          });
        },
      );
    }).toList();
  }

  void _save() async {
    SkillRequest _skill = SkillRequest(skill: _selectedSkills);
    try {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      dynamic _user = await SkillServices().updateskill(_skill, provider.token);

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
