import 'package:go_router/go_router.dart';
import 'package:scholar/core/presentation/screens/logIn.dart';
import 'core/feature_login/presentation/LogInView.dart' show LogInView;
import 'core/feature_on_boarding/presentation/OnbordingScreenView.dart';
import 'core/feature_splash_screen/presentation/SplashScreenView.dart';
import 'core/presentation/screens/home_screen.dart';
import 'core/presentation/screens/onbording_screen.dart';
import 'core/presentation/screens/splash_screen.dart';

final router = GoRouter(

  //الشاشة المبدئية التي ستظهر اول مانعمل run السؤول هو السطر 10 الي تحتي مباشرة

  initialLocation: '/splashScreenView',//splashScreen


  routes: [

    GoRoute(
      path: '/splashScreenView',
      builder: (context, state) => SplashScreenView(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreenView(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/LogInView', //login
      builder: (context, state) => LogInView(),
    ),
  ],
);