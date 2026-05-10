
import 'package:flutter/material.dart';

Widget buildButton({
  required IconData icon,
  required String text,
  required  Color color ,
  required VoidCallback onTap,
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
          Icon(icon, color: Colors.white),
          SizedBox(width: 15),
          Text(
            text,
            style:  TextStyle(color: Colors.white, fontSize: 16),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    ),
  );
}
