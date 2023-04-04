import 'package:app/router/go_router_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  routes: $appRoutes,
  navigatorKey: navigatorKey,
  initialLocation: const HomeRoute().location,
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
);
