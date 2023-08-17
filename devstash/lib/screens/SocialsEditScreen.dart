import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/education.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SocialsEditScreen2 extends StatefulWidget {
  @override
  _SocialsEditScreen2State createState() => _SocialsEditScreen2State();
}

class _SocialsEditScreen2State extends State<SocialsEditScreen2> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // SaveProfile _saveProfile = SaveProfile();

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
  List<String> _selectedSkills = [];

  List<Map<String, String>> _socialsList = [];

  final List<String> _socialPlatforms = [
    'Twitter',
    'Instagram',
    'LinkedIn',
    'GitHub',
  ];

  String _selectedPlatform = 'Twitter';
  List<String> _selectedHandleTypes = [];
  bool _showSocialDropdown = true;

  TextEditingController _usernameController = TextEditingController();

  List<Map<String, String>> _educationList = [];

  final List<String> _educationLevels = [
    '10th',
    '12th',
    'B.Tech',
    // Add more education levels as needed
  ];

  final Map<String, List<String>> _subjectsByLevel = {
    'B.Tech': [
      'Computer Science',
      'Civil',
      '...'
    ], // Add more subjects for B.Tech as needed
    '10th': ['...', '......', '..'], // Add subjects for 10th as needed
    '12th': ['Biology', 'Maths', '...'], // Add more subjects for 12th as needed
  };

  TextEditingController _schoolNameController = TextEditingController();
  String _selectedLevel = 'B.Tech';
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _fromYearController = TextEditingController();
  TextEditingController _toYearController = TextEditingController();

  void _onUsernameEditingComplete() {
    _addSocial();
    _usernameController.clear();
  }

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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Skills',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _buildSkillChips(),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Socials',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: _buildSocialFields(),
            ),
            const SizedBox(height: 16.0),
            if (_showSocialDropdown)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedPlatform,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPlatform = newValue!;
                        });
                      },
                      items: _socialPlatforms
                          .where((platform) =>
                              !_selectedHandleTypes.contains(platform))
                          .map((String platform) {
                        return DropdownMenuItem<String>(
                          value: platform,
                          child: Text(platform),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          getSocialDomain(_selectedPlatform),
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _usernameController,
                            onEditingComplete: _onUsernameEditingComplete,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 24.0),
            const SizedBox(height: 24.0),
            const Text(
              'Education',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._buildEducationFields(),
                const SizedBox(height: 16.0),
                _buildAddEducationField(),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Contact',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            ElevatedButton(
              onPressed: _saveProfileDetails,
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
            if (selected) {
              _selectedSkills.add(skill);
            } else {
              _selectedSkills.remove(skill);
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildSocialFields() {
    List<Widget> socialFields = [];

    for (int i = 0; i < _socialsList.length; i++) {
      Map<String, String> social = _socialsList[i];
      String url = social['url'] ?? '';

      socialFields.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: url),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  String type = _socialsList[i]['type']!;
                  _selectedHandleTypes.remove(type);
                  setState(() {
                    _removeSocial(i);
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return socialFields;
  }

  void _removeSocial(int index) {
    String type = _socialsList[index]['type']!;
    _selectedHandleTypes.remove(type);
    setState(() {
      _socialsList.removeAt(index);
      _showSocialDropdown =
          _selectedHandleTypes.length < _socialPlatforms.length;
      if (_showSocialDropdown) {
        _selectedPlatform = _socialPlatforms.firstWhere(
          (platform) => !_selectedHandleTypes.contains(platform),
          orElse: () => _selectedPlatform,
        );
      }
    });
  }

  void _addSocial() {
    String username = _usernameController.text;

    if (username.isNotEmpty) {
      String url = getSocialDomain(_selectedPlatform) + username;
      setState(() {
        _socialsList.add({
          'type': _selectedPlatform,
          'url': 'https://$url',
        });
        _selectedHandleTypes.add(_selectedPlatform);

        _usernameController.clear();
        _showSocialDropdown =
            _selectedHandleTypes.length < _socialPlatforms.length;
        if (_showSocialDropdown) {
          _selectedPlatform = _socialPlatforms.firstWhere(
            (platform) => !_selectedHandleTypes.contains(platform),
            orElse: () => _selectedPlatform,
          );
        }
      });
    }
  }

  String getSocialDomain(String type) {
    // Implement the logic to map the handle type to the corresponding domain.
    // Customize this logic as needed based on the social media platforms you support.
    switch (type) {
      case 'Twitter':
        return 'twitter.com/';
      case 'Instagram':
        return 'instagram.com/';
      case 'LinkedIn':
        return 'linkedin.com/in/';
      case 'GitHub':
        return 'github.com/';
      // Add more cases for additional social media platforms.
      default:
        return '@domain'; // Replace with a default domain placeholder or handle unsupported types.
    }
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
              ElevatedButton(
                onPressed: _addEducationEntry,
                child: const Text('Add'),
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

  List<Widget> _buildEducationFields() {
    List<Widget> educationFields = [];

    for (int i = 0; i < _educationList.length; i++) {
      Map<String, String> education = _educationList[i];
      String level = education['level'] ?? '';
      String schoolName = education['schoolName'] ?? '';
      String subject = education['subject'] ?? '';
      String fromYear = education['fromYear'] ?? '';
      String toYear = education['toYear'] ?? '';

      educationFields.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text('Level: $level'),
              const SizedBox(height: 8.0),
              Text('College/School Name: $schoolName'),
              const SizedBox(height: 8.0),
              Text('Subject: $subject'),
              const SizedBox(height: 8.0),
              Text('From Year: $fromYear'),
              const SizedBox(height: 8.0),
              Text('To Year: $toYear'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _educationList.removeAt(i);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return educationFields;
  }

  void _addEducationEntry() {
    String level = _selectedLevel;
    String schoolName = _schoolNameController.text;
    String subject = _subjectController.text;
    String fromYear = _fromYearController.text;
    String toYear = _toYearController.text;

    if (schoolName.isNotEmpty && fromYear.isNotEmpty && toYear.isNotEmpty) {
      setState(() {
        _educationList.add({
          'level': level,
          'schoolName': schoolName,
          'subject': subject,
          'fromYear': fromYear,
          'toYear': toYear,
        });
      });

      _schoolNameController.clear();
      _subjectController.clear();
      _fromYearController.clear();
      _toYearController.clear();
    }
  }

  void _saveProfileDetails() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;

    UserProfile userprofile = UserProfile(
        name: name,
        username: name,
        description: description,
        email: email);
    try {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      // dynamic _user = await _saveProfile.save(userprofile, provider.token);
      // log(_user.toString());
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
