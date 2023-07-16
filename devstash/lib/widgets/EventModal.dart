import 'package:devstash/utils/utils.dart';
import 'package:flutter/material.dart';

class EventModal extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String, String, DateTime) onEventAdded;

  const EventModal({
    required this.selectedDate,
    required this.onEventAdded,
  });

  @override
  _EventModalState createState() => _EventModalState();
}

class _EventModalState extends State<EventModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Add Event',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Event Title',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the event title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the event description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Event Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        formatDate(_selectedDate) ?? 'Select a date',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final title = _titleController.text;
                        final description = _descriptionController.text;
                        widget.onEventAdded(
                            title, description, _selectedDate);
                        Navigator.pop(context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Customize the date picker color
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }
}
