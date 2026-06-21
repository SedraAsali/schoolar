import 'package:flutter/material.dart';


//مشان التحكم بالنقط اسفل الشاشة عند الانتقال من شاشة لاخرى يتغير شكلها

class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin:  EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}