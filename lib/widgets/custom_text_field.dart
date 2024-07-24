import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.hinttext, this.onChanged, this.obstracttext = false});
  String? hinttext;
  bool obstracttext;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obstracttext,
      validator: (data) {
        if (data!.isEmpty) {
          return " field is required";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
