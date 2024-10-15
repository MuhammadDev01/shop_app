import 'package:flutter/material.dart';

Widget customButton({
  final VoidCallback? onTap,
  required String textbutton,
  required Color color,
  required BuildContext context,
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
      height: 60,
      width: 500,
      child: Text(
        textbutton.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,
        )
      ),
    ),
  );
}
