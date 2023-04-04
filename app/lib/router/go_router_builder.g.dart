// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router_builder.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'singleton',
          factory: $SingletonRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'state_provider',
          factory: $StateProviderRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'composed_provider',
          factory: $ComposedProviderRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'inherited_providerP/:id',
          factory: $InheritedProviderRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'vehicle_manager',
          factory: $VehicleManagerRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details/:vehicleId',
              factory: $VehicleDetailsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SingletonRouteExtension on SingletonRoute {
  static SingletonRoute _fromState(GoRouterState state) =>
      const SingletonRoute();

  String get location => GoRouteData.$location(
        '/singleton',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $StateProviderRouteExtension on StateProviderRoute {
  static StateProviderRoute _fromState(GoRouterState state) =>
      const StateProviderRoute();

  String get location => GoRouteData.$location(
        '/state_provider',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ComposedProviderRouteExtension on ComposedProviderRoute {
  static ComposedProviderRoute _fromState(GoRouterState state) =>
      const ComposedProviderRoute();

  String get location => GoRouteData.$location(
        '/composed_provider',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $InheritedProviderRouteExtension on InheritedProviderRoute {
  static InheritedProviderRoute _fromState(GoRouterState state) =>
      InheritedProviderRoute(
        id: state.params['id']!,
      );

  String get location => GoRouteData.$location(
        '/inherited_providerP/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $VehicleManagerRouteExtension on VehicleManagerRoute {
  static VehicleManagerRoute _fromState(GoRouterState state) =>
      const VehicleManagerRoute();

  String get location => GoRouteData.$location(
        '/vehicle_manager',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $VehicleDetailsRouteExtension on VehicleDetailsRoute {
  static VehicleDetailsRoute _fromState(GoRouterState state) =>
      VehicleDetailsRoute(
        vehicleId: state.params['vehicleId']!,
      );

  String get location => GoRouteData.$location(
        '/vehicle_manager/details/${Uri.encodeComponent(vehicleId)}',
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
