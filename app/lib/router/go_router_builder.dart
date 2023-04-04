import 'package:app/pages/composed_provider_page.dart';
import 'package:app/pages/details_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/inherited_provider_page.dart';
import 'package:app/pages/items_page.dart';
import 'package:app/pages/singleton_page.dart';
import 'package:app/pages/state_provider_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'go_router_builder.g.dart';

// This class helps to generate all the routes see :
// https://pub.dev/packages/go_router_builder

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ItemsRoute>(
      path: 'items',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<DetailsRoute>(
          path: ':itemId',
        ),
      ],
    ),
    TypedGoRoute<SingletonRoute>(
      path: 'singleton',
    ),
    TypedGoRoute<StateProviderRoute>(
      path: 'state_provider',
    ),
    TypedGoRoute<ComposedProviderRoute>(
      path: 'composed_provider',
    ),
    TypedGoRoute<InheritedProviderRoute>(
      path: 'inherited_providerP/:id',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class SingletonRoute extends GoRouteData {
  const SingletonRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SingletonPage();
  }
}

class StateProviderRoute extends GoRouteData {
  const StateProviderRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StateProviderPage();
  }
}

class ComposedProviderRoute extends GoRouteData {
  const ComposedProviderRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ComposedProviderPage();
  }
}

class InheritedProviderRoute extends GoRouteData {
  const InheritedProviderRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InheritedProviderPage(id: id);
  }
}

class ItemsRoute extends GoRouteData {
  const ItemsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ItemsPage();
  }
}

class DetailsRoute extends GoRouteData {
  const DetailsRoute({required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailsPage(itemId: itemId);
  }
}
