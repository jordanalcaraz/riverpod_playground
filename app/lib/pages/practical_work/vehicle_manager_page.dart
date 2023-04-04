import 'package:app/router/go_router_builder.dart';
import 'package:app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Vehicle {
  const Vehicle({
    required this.id,
    required this.name,
    required this.year,
    required this.description,
  });

  final String id;
  final String name;
  final String year;
  final String description;
}

List<Vehicle> currentVehicles = [];

bool yearIsValid(String year) {
  return int.tryParse(year) != null;
}

final showAddSectionProvider = StateProvider<bool>(
  (ref) => false,
);

final vehiclesProvider = StateProvider<List<Vehicle>>(
  (ref) => [],
);

class VehicleManagerPage extends StatelessWidget {
  const VehicleManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PracticalWork'),
        actions: const [
          _AppBarButton(),
        ],
      ),
      body: Column(
        children: const [
          _AddSection(),
          Text('Vehicle list :'),
          Expanded(
            child: _VehicleList(),
          ),
        ],
      ),
    );
  }
}

class _VehicleList extends ConsumerWidget {
  const _VehicleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesProvider);
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: vehicles.length,
      itemBuilder: (BuildContext context, int index) {
        final vehicle = vehicles[index];
        final id = vehicle.id;
        return ListTile(
          title: Text(vehicle.name),
          subtitle: Text(id),
          trailing: IconButton(
            onPressed: () {
              ref.read(vehiclesProvider.notifier).update((old) {
                final copy = old.toList();
                copy.removeAt(index);
                return copy;
              });
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: () {
            currentVehicles = vehicles;
            VehicleDetailsRoute(vehicleId: id).go(context);
          },
        );
      },
    );
  }
}

class _AppBarButton extends ConsumerWidget {
  const _AppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAddSection = ref.watch(showAddSectionProvider);
    if (showAddSection) {
      return IconButton(
        onPressed: () {
          ref.read(showAddSectionProvider.notifier).state = false;
        },
        icon: const Icon(Icons.close),
      );
    }

    return IconButton(
      onPressed: () {
        ref.read(showAddSectionProvider.notifier).state = true;
      },
      icon: const Icon(Icons.add),
    );
  }
}

final nameProvider = StateProvider<String>(
  (ref) => '',
);

final yearProvider = StateProvider<String>(
  (ref) => '',
);

final descriptionProvider = StateProvider<String>(
  (ref) => '',
);

class _AddSection extends ConsumerWidget {
  const _AddSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAddSection = ref.watch(showAddSectionProvider);

    if (!showAddSection) {
      return const SizedBox();
    }
    final name = ref.watch(nameProvider);
    final year = ref.watch(yearProvider);
    final canAdd = name.isNotEmpty && yearIsValid(year);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      color: Colors.tealAccent,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            onChanged: (value) {
              ref.read(nameProvider.notifier).state = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Year',
            ),
            onChanged: (value) {
              ref.read(yearProvider.notifier).state = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            onChanged: (value) {
              ref.read(descriptionProvider.notifier).state = value;
            },
          ),
          AppButton(
            text: 'Add',
            onPressed: canAdd
                ? () {
                    final description = ref.read(descriptionProvider);
                    final vehicle = Vehicle(
                      id: const Uuid().v1(),
                      name: name,
                      year: year,
                      description: description,
                    );
                    ref.read(vehiclesProvider.notifier).update(
                          (old) => [
                            ...old,
                            vehicle,
                          ],
                        );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
