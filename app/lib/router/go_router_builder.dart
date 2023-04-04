import 'package:app/pages/composed_provider_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/inherited_provider_page.dart';
import 'package:app/pages/practical_work/vehicle_details_page.dart';
import 'package:app/pages/practical_work/vehicle_manager_page.dart';
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
    TypedGoRoute<VehicleManagerRoute>(
      path: 'vehicle_manager',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<VehicleDetailsRoute>(
          path: 'details/:vehicleId',
        ),
      ],
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

class VehicleManagerRoute extends GoRouteData {
  const VehicleManagerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VehicleManagerPage();
  }
}

class VehicleDetailsRoute extends GoRouteData {
  const VehicleDetailsRoute({required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VehicleDetailsPage(vehicleId: vehicleId);
  }
}
