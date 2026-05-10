import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scholar/core/presentation/providers/theme_provider.dart';
import 'package:scholar/router.dart';
import 'package:scholar/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final themeModeAsync = ref.watch(fullThemeNotifierProvider);

    final baseTextTheme = GoogleFonts.cairoTextTheme();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: router,
      title: 'معهدي',

      theme: AppTheme.light.copyWith(
        textTheme: baseTextTheme,
      ),

      darkTheme: AppTheme.dark.copyWith(
        textTheme: baseTextTheme,
      ),

      themeMode: themeModeAsync.when(
        data: (mode) => mode,
        error: (_, __) => ThemeMode.system,
        loading: () => ThemeMode.system,
      ),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
    );
  }
}