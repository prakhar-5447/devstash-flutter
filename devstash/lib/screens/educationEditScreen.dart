import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/request/educationRequest.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:devstash/screens/educationList.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EducationEditProfileScreen extends StatefulWidget {
  final String title;
  final EducationResponse? educationList;

  // Constructor with parameters
  EducationEditProfileScreen({required this.title, this.educationList});

  @override
  _EducationEditProfileScreenState createState() =>
      _EducationEditProfileScreenState();
}

class _EducationEditProfileScreenState
    extends State<EducationEditProfileScreen> {
  EducationServices saveEducation = EducationServices();

  final List<String> _educationLevels = [
    '10th',
    '12th',
    'B.Tech',
  ];

  final Map<String, List<String>> _subjectsByLevel = {
    'B.Tech': ['Computer Science', 'Civil', '...'],
    '10th': ['...', '......', '..'],
    '12th': ['Biology', 'Maths', '...'],
  };

  TextEditingController _schoolNameController = TextEditingController();
  String _selectedLevel = 'B.Tech';
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _fromYearController = TextEditingController();
  TextEditingController _toYearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.educationList != null) {
      _schoolNameController.text = widget.educationList!.collegeorSchoolName!;
      _selectedLevel = widget.educationList!.educationLevel!;
      _subjectController.text = widget.educationList!.subject!;
      _fromYearController.text = widget.educationList!.fromYear!;
      _toYearController.text = widget.educationList!.toYear!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Education'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Education',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildAddEducationField(),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: widget.title == "Add" && widget.educationList == null
                  ? _createEducation
                  : _saveeducation,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddEducationField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedLevel,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLevel = newValue!;
                    });
                    _subjectController.text =
                        _subjectsByLevel[_selectedLevel]!.first;
                  },
                  items: _educationLevels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _schoolNameController,
                  onChanged: (newValue) {},
                  decoration: const InputDecoration(
                    labelText: 'College/School Name',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          DropdownButton<String>(
            value: _subjectController.text.isEmpty
                ? _subjectsByLevel[_selectedLevel]!.first
                : _subjectController.text,
            onChanged: (String? newValue) {
              setState(() {
                _subjectController.text = newValue!;
              });
            },
            items: _subjectsByLevel[_selectedLevel]!.map((subject) {
              return DropdownMenuItem<String>(
                value: subject,
                child: Text(subject),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _fromYearController,
                  onChanged: (newValue) {},
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'From Year',
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _toYearController,
                  onChanged: (newValue) {},
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'To Year',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveeducation() async {
    String schoolName = _schoolNameController.text;
    String subject = _subjectController.text;
    String fromYear = _fromYearController.text;
    String toYear = _toYearController.text;
    EducationRequest _educationList = EducationRequest(
        id: widget.educationList!.id!,
        collegeorSchoolName: schoolName,
        educationLevel: _selectedLevel,
        fromYear: fromYear,
        toYear: toYear,
        subject: subject);

    try {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      dynamic _user =
          await saveEducation.updateEducation(_educationList, provider.token);
      log(_user.toString());
      Fluttertoast.showToast(
        msg: "Successfully Save Details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
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

  void _createEducation() async {
    String schoolName = _schoolNameController.text;
    String subject = _subjectController.text;
    String fromYear = _fromYearController.text;
    String toYear = _toYearController.text;
    EducationRequest _educationList = EducationRequest(
        collegeorSchoolName: schoolName,
        educationLevel: _selectedLevel,
        fromYear: fromYear,
        toYear: toYear,
        subject: subject);

    try {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      dynamic _user =
          await saveEducation.create(_educationList, provider.token);
      log(_user.toString());
      Fluttertoast.showToast(
        msg: "Successfully Save Details",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
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
