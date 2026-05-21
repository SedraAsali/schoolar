import 'package:flutter/material.dart';

Widget buildSupportCard ({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      leading: Icon(icon, color:Theme.of(context).colorScheme.secondary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    ),
  );
}
