//الازرار اللي بالبروفايل

import 'package:flutter/material.dart';

Widget buildButton({
  required IconData icon,
  required String text,
  required  Color color ,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding:  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSecondary),
          SizedBox(width: 15),
          Text(
            text,
            style:  TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 16),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,color: Theme.of(context).colorScheme.onSecondary, size: 16),
        ],
      ),
    ),
  );
}
