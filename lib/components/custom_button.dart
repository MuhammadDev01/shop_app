import 'package:flutter/material.dart';

Widget customButton({
  final VoidCallback? onTap,
  required String textbutton,
  required Color color,
  Color colorText = Colors.white,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      width: double.infinity,
      height: 60,
      child: Text(
        textbutton.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: colorText,
        ),
      ),
    ),
  );
}
