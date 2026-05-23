import 'package:flutter/material.dart';
import '../../domain/models/fag_modle.dart';

class FaqTile extends StatelessWidget {
  final FaqItem item;

  const FaqTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor:
        Theme.of(context).colorScheme.primary.withOpacity(0.3),

        title: Text(
          item.question,
          style: const TextStyle(fontSize: 18),
        ),

        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(item.answer),
          ),
        ],
      ),
    );
  }
}