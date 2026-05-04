import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class ThemeDialogWidget extends ConsumerWidget {
  const ThemeDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(fullThemeNotifierProvider);
    final selectedMode = currentTheme.when(
      data: (mode) => mode,
      loading: () => ThemeMode.system,
      error: (_, __) => ThemeMode.system,
    );

    return AlertDialog(
      title: Text('اختر السمة'),
      content: RadioGroup<ThemeMode>(
        groupValue: selectedMode,
        onChanged: (value) async {
          await ref
              .read(fullThemeNotifierProvider.notifier)
              .setThemeMode(value!);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text('كاشف'),
              value: ThemeMode.light,
            ),
            RadioListTile<ThemeMode>(
              title: Text('داكن'),
              value: ThemeMode.dark,
            ),
            RadioListTile<ThemeMode>(
              title: Text('النظام'),
              value: ThemeMode.system,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إغلاق'),
        ),
      ],
    );
  }
}
