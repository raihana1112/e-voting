import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class VoteDate extends StatefulWidget {
  final String title;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;

  const VoteDate({
    Key? key,
    required this.title,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  _VoteDateState createState() => _VoteDateState();
}

class _VoteDateState extends State<VoteDate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showOmniDateTimePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
          is24HourMode: false,
          isShowSeconds: false,
        );
        if (pickedDate != null) {
          widget.controller.text = pickedDate.toString();
        }
      },
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Colors.indigo[400],
          ),
          hintText: widget.hint,
        ),
        readOnly: true,
      ),
    );
  }
}
