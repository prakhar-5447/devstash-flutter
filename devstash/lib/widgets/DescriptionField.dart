import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  const DescriptionField({
    Key? key,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _DescriptionFieldState createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          controller: _controller,
          maxLines: 5,
          maxLength: 200, // Maximum character limit
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            hintText: 'Description',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              widget.onChanged?.call(value);
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
      ),
    );
  }
}
