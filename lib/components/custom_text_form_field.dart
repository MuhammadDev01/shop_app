import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.context,
    this.onSubmitted,
    required this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    required this.borderColor,
    this.onSaved,
    required this.textInputType,
    this.obscureText = false,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? label;
  final BuildContext? context;
  final void Function(String)? onSubmitted;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final void Function(String)? onChange;
  final Color borderColor;
  final void Function(String?)? onSaved;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          prefixIconColor: Colors.grey,
          label: label,
          hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey),
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
  }
}
