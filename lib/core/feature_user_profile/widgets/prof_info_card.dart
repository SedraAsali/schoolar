
import 'package:flutter/material.dart';

Widget buildInfoCard(String number, String title, BuildContext context) {
  return Container(
    width: 120,
    padding:  EdgeInsets.symmetric(
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Text(
          number,
          style:  TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style:  TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}