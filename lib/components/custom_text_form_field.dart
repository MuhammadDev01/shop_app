import 'package:flutter/material.dart';

Widget customTextFormField({
  TextEditingController? controller,
  String? hintText,
  Widget? label,
  void Function(String)? onSubmitted,
  required Icon prefixIcon,
  IconButton? suffixIcon,
  bool obscureText = false,
  void Function(String)? onChange,
  void Function(String?)? onSaved,
  required TextInputType textInputType,
}) =>
    TextFormField(
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      keyboardType: textInputType,
      onSaved: onSaved,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field Is required';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        label: label,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
      ),
    );
