import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey[400], fontSize: 15, fontWeight: FontWeight.bold),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Empty Field";
        }
        if (value.length < 3) {
          return "Name should be more than 3 letters";
        }
        return null;
      },
    );
  }
}
