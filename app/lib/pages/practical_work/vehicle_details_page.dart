import 'package:app/pages/practical_work/vehicle_manager_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vehicleIdGetter = Provider<String>(
  (ref) => throw UnimplementedError(),
);

final vehicleProvider = Provider.family<Vehicle?, String>(
  (ref, vehicleId) {
    final vehicles = ref.watch(vehiclesProvider);
    return vehicles.firstWhereOrNull((element) => element.id == vehicleId);
  },
);

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        vehicleIdGetter.overrideWithValue(vehicleId),
      ],
      child: const _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VehicleDetailsPage')),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _IdText(),
          _NameText(),
          _YearText(),
          _DescriptionText(),
        ],
      ),
    );
  }
}

class _IdText extends ConsumerWidget {
  const _IdText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleId = ref.watch(vehicleIdGetter);
    return Text('id: $vehicleId');
  }
}

class _NameText extends ConsumerWidget {
  const _NameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleId = ref.watch(vehicleIdGetter);
    final name = ref.watch(vehicleProvider(vehicleId).select((value) => value?.name ?? ''));
    return Text('name: $name');
  }
}

class _YearText extends ConsumerWidget {
  const _YearText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleId = ref.watch(vehicleIdGetter);
    final year = ref.watch(vehicleProvider(vehicleId).select((value) => value?.year ?? ''));
    return Text('year: $year');
  }
}

class _DescriptionText extends ConsumerWidget {
  const _DescriptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleId = ref.watch(vehicleIdGetter);
    final description = ref.watch(vehicleProvider(vehicleId).select((value) => value?.description ?? ''));
    return Text('description: $description');
  }
}
