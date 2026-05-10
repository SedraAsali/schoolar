import 'package:go_router/go_router.dart';
import 'package:scholar/core/presentation/screens/home_screen.dart';

import 'core/presentation/screens/logIn.dart';

final router = GoRouter(
    initialLocation: '/',
    routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context,state) => HomeScreen(),
    )
]

);
