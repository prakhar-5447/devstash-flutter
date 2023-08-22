import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/services/imageServices.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/widgets/DescriptionField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectAddScreen extends StatefulWidget {
  final Function(ProjectResponse) addProject;
  ProjectAddScreen({super.key, required this.addProject});

  @override
  _ProjectAddScreenState createState() => _ProjectAddScreenState();
}

class _ProjectAddScreenState extends State<ProjectAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _allCollaboratorsID = ['64d0eb91908b9fdbe1c77250'];
  final List<String> _allTechnologies = ['html', 'css', 'javascript'];
  final List<String> _allProjectType = [
    'Select a value',
    'Web',
    'Android',
    'Other'
  ];
  bool _isLoading = false;

  late XFile _pickedImage = XFile('');
  late String _image = '';
  late String _title;
  late String _url;
  late String _description;
  final List<String> _technologies = [];
  final List<String> _collaboratorsID = [];
  String _projectType = '';
  final List<String> _hashtags = [];

  final TextEditingController _imagecontroller = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  late TextEditingController _hashtagController;
  late FocusNode _hashtagFocusNode;

  @override
  void initState() {
    super.initState();
    _hashtagController = TextEditingController();
    _hashtagFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _hashtagController.dispose();
    _hashtagFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_pickedImage.path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image first'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String? imageData = await ImageServices().addImage(_pickedImage);

    setState(() {
      _isLoading = false;
    });

    if (imageData != null) {
      setState(() {
        _image = imageData;
        _imagecontroller.text = imageData;
      });
    }
  }

  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasScheme ?? false;
  }

  void _addHashtag() {
    final String hashtag = _hashtagController.text.trim();
    if (hashtag.isNotEmpty && !_hashtags.contains(hashtag)) {
      setState(() {
        _hashtags.add(hashtag);
        _hashtagController.clear();
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _projectType.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      ProjectRequest req = ProjectRequest(_image, _title, _url, _description,
          _technologies, _collaboratorsID, _projectType, _hashtags);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        ProjectResponse? newProject =
            await ProjectServices().addProject(token, req);
        if (newProject != null) {
          _formKey.currentState!.reset();
          _imagecontroller.clear();
          _urlController.clear();
          _hashtagController.clear();
          setState(() {
            _technologies.clear();
            _collaboratorsID.clear();
            _hashtags.clear();
            _projectType = '';
          });
          widget.addProject(newProject);
          Navigator.pop(context);
        }
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildHashtagField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _hashtagController,
                focusNode: _hashtagFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Add hashtag...',
                ),
                onChanged: (value) {
                  // Handle hashtag field changes
                },
                onFieldSubmitted: (value) {
                  _addHashtag();
                },
              ),
            ),
            IconButton(
              onPressed: () {
                _addHashtag();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        Wrap(
          spacing: 8.0,
          children: _hashtags.map<Widget>((hashtag) {
            return Chip(
              label: Text(hashtag),
              onDeleted: () {
                setState(() {
                  _hashtags.remove(hashtag);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSingleItemDropdown(
    String labelText,
    List<String> items,
    String selectedValue,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      value: selectedValue.isEmpty ? 'Select a value' : selectedValue,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
          if (selectedValue != 'Select a value') {
            _projectType = selectedValue;
          } else {
            _projectType = '';
          }
        });
      },
      validator: (value) {
        if (value == null || _projectType.isEmpty) {
          return 'Please select a value';
        }
        return null;
      },
      isExpanded: true,
      iconSize: 30,
    );
  }

  Widget _buildArrayDropdown(
      String labelText, List<String> items, List<String> selectedValues) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      value: selectedValues.isNotEmpty ? selectedValues[0] : null,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValues.clear();
          if (newValue != null) {
            _collaboratorsID.add(newValue);
          }
        });
      },
      validator: (value) {
        if (_collaboratorsID == null) {
          return 'Please select at least one item';
        }
        return null;
      },
      isExpanded: true,
      iconSize: 30,
    );
  }

  RadioListTile<String> _buildProjectTypeRadio(
      String projectType, String value) {
    return RadioListTile<String>(
      title: Text(projectType),
      value: value,
      groupValue: _projectType,
      onChanged: (newValue) {
        setState(() {
          _projectType = newValue!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text('Upload Image'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Image'),
                    readOnly: true,
                    controller: _imagecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please upload image first';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'URL'),
                    controller: _urlController,
                    onChanged: (value) {
                      setState(() {
                        _url = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                      if (!isValidUrl(value)) {
                        return 'Please enter a valid URL';
                      }
                      return null;
                    },
                  ),
                  DescriptionField(
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                  TypeAheadField<String>(
                    textFieldConfiguration: const TextFieldConfiguration(
                      decoration: InputDecoration(
                        labelText: 'Technologies',
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return _allTechnologies
                          .where((technology) =>
                              technology.contains(pattern) &&
                              !_technologies.contains(technology))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _technologies.add(suggestion);
                        _allTechnologies
                            .remove(suggestion); // Remove selected technology
                      });
                    },
                    noItemsFoundBuilder: (context) {
                      return const SizedBox.shrink();
                    },
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _technologies.map<Widget>((technology) {
                      return Chip(
                        label: Text(technology),
                        onDeleted: () {
                          setState(() {
                            _technologies.remove(technology);
                            _allTechnologies
                                .add(technology); // Add back to suggestions
                          });
                        },
                      );
                    }).toList(),
                  ),
                  _buildArrayDropdown(
                    'Collaborators IDs',
                    _allCollaboratorsID,
                    _collaboratorsID,
                  ),
                  _buildSingleItemDropdown(
                    'Project Type',
                    _allProjectType,
                    _projectType,
                  ),
                  _buildHashtagField(),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) // Show loader if loading
            Container(
              color: Colors.black
                  .withOpacity(0.5), // Semi-transparent black overlay
              child: const Center(
                child: CircularProgressIndicator(), // Show a loading indicator
              ),
            ),
        ],
      ),
    );
  }
}
