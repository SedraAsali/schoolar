import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_favorites/presentation/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:scholar/core/feature_signup/presentation/bloc/sign_up_bloc.dart';
import 'package:scholar/core/presentation/providers/theme_provider.dart';
import 'package:scholar/helper/global_variable_provide.dart';
import 'package:scholar/router.dart';
import 'package:scholar/theme.dart';

import 'core/feature_favorites/presentation/add_favorite_bloc/add_favorite_bloc.dart';
import 'core/feature_favorites/presentation/favorites_bloc/favorites_view_bloc.dart';
import 'core/feature_home/presentation/academies_bloc/home_view_bloc.dart';
import 'core/feature_login/presentation/bloc/log_in_bloc.dart';
import 'core/feature_user_profile/cubit_profile/profile_cubit.dart';
import 'core/feature_user_profile/get_profile_cubit/get_profile_cubit.dart';
import 'core/feature_user_profile/provider/profile_provider.dart';
import 'helper/text_field_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LogInBloc()..add(LogInInit()),
          ),
          BlocProvider(
            create: (_) => SignUpBloc()..add(SignUpInit()),
          ),
          BlocProvider<HomeViewBloc>(
            //PrefDetailBloc
            create: (context) =>
            HomeViewBloc()),
          BlocProvider(
            create: (context) => AddFavoriteBloc(),
          ),
          BlocProvider(
            create: (context) => DeleteFavoriteBloc(),
          ),
          BlocProvider(
            create: (context) => FavoritesViewBloc(),
          ),
          BlocProvider<GetProfileCubit>(
            create: (context) => GetProfileCubit(),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
          ),
          // BlocProvider(
          //   create: (_) => HomeViewBloc(),
          // ),


        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TextFieldProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => GlobalVariableProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ProfileProvider(),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
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