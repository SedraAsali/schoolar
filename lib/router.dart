import 'package:go_router/go_router.dart';
import 'package:scholar/core/presentation/screens/logIn.dart';
import 'core/presentation/screens/home_screen.dart';
import 'core/presentation/screens/onbording_screen.dart';
import 'core/presentation/screens/splash_screen.dart';

final router = GoRouter(

  //الشاشة المبدئية التي ستظهر اول مانعمل run السؤول هو السطر 10 الي تحتي مباشرة

  initialLocation: '/splashScreen',


  routes: [

    GoRoute(
      path: '/splashScreen',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LogIn(),
    ),
  ],
);