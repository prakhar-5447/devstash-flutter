import 'dart:developer';

import 'package:devstash/models/request/contactRequest.dart';
import 'package:devstash/models/response/contactResponse.dart';
import 'package:devstash/screens/profile/ProfileScreen.dart';
import 'package:devstash/services/ContactServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  final ContactResponse? contact;

  ContactScreen({super.key, required this.contact});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _city = "", _state = "", _country = "", _code = "";
  final _formKey = GlobalKey<FormState>();
  ContactServices contactServices = ContactServices();

  List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
  ];

  List<String> states = [
    'California',
    'Texas',
    'Florida',
  ];

  Map<String, String> countries = {
    'United States': '91',
    'Canada': '01',
    'United Kingdom': '912',
  };

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _city = _cityController.text = widget.contact!.city;
      _state = _stateController.text = widget.contact!.state;
      _country = _countryController.text = widget.contact!.country;
      _phoneController.text = widget.contact!.phoneNo;
      _code = widget.contact!.countryCode;
    } else {
      _city = _cityController.text = "";
      _state = _stateController.text = "";
      _country = _countryController.text = "";
      _phoneController.text = "";
      _code = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildAutoCompleteTextField(
              controller: _cityController,
              labelText: 'City',
              suggestionsCallback: fetchCitySuggestions,
              validator: (value) {
                if (_city.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              change: (value) {
                setState(() {
                  _city = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            _buildAutoCompleteTextField(
              controller: _stateController,
              labelText: 'State',
              suggestionsCallback: fetchStateSuggestions,
              validator: (value) {
                if (_state.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              change: (value) {
                setState(() {
                  _state = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            _buildAutoCompleteTextField(
              controller: _countryController,
              labelText: 'Country',
              suggestionsCallback: fetchCountrySuggestions,
              validator: (value) {
                if (_country.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              change: (value) {
                setState(() {
                  _country = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _saveContactDetails,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoCompleteTextField(
      {required TextEditingController controller,
      required String labelText,
      required Future<List<String>> Function(String) suggestionsCallback,
      required String? Function(String?) validator,
      required void Function(String) change}) {
    return FutureBuilder<List<String>>(
      future: suggestionsCallback(controller.text),
      builder: (context, snapshot) {
        return TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            onChanged: (value) {
              change("");
            },
            decoration: InputDecoration(labelText: labelText),
          ),
          suggestionsCallback: (pattern) async {
            return suggestionsCallback(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            controller.text = suggestion;
            change(suggestion);
            _country != "" ? _code = countries[suggestion] ?? '' : _code = '';
          },
          validator: validator,
        );
      },
    );
  }

  Future<List<String>> fetchCitySuggestions(String input) async {
    List<String> filteredCities = cities
        .where((city) => city.toLowerCase().contains(input.toLowerCase()))
        .toList();

    return filteredCities.take(3).toList();
  }

  Future<List<String>> fetchStateSuggestions(String input) async {
    List<String> filteredStates = states
        .where((state) => state.toLowerCase().contains(input.toLowerCase()))
        .toList();

    return filteredStates.take(3).toList();
  }

  Future<List<String>> fetchCountrySuggestions(String input) async {
    List<String> filteredCountries = countries.keys
        .where((country) => country.toLowerCase().contains(input.toLowerCase()))
        .toList();

    return filteredCountries.take(3).toList();
  }

  void _saveContactDetails() async {
    if (_formKey.currentState!.validate()) {
      String city = _cityController.text;
      String state = _stateController.text;
      String country = _countryController.text;
      String phone = _phoneController.text;
      ContactRequest contact = ContactRequest(
          city: city,
          state: state,
          country: country,
          phoneNo: phone,
          countryCode: _code);

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          dynamic res = await contactServices.updateContact(contact, token);
          Fluttertoast.showToast(
            msg: res['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          if (res['success']) {
            Navigator.pop(context);
          }
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
}
