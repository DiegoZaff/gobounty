import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
       
      ],
    )
  ],
);
