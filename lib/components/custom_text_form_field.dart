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
  required Color borderColor,
  void Function(String?)? onSaved,
  required TextInputType textInputType,
}) =>
    SizedBox(
      width: 500,
      child: TextFormField(
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
          contentPadding: EdgeInsets.zero,
          label: label,
          hintText: hintText,
          suffixIcon: suffixIcon,
          focusColor: Colors.cyan,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
