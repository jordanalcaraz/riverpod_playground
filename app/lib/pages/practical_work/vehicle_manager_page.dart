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

class VehicleManagerPage extends StatefulWidget {
  const VehicleManagerPage({Key? key}) : super(key: key);

  @override
  State<VehicleManagerPage> createState() => _VehicleManagerPageState();
}

class _VehicleManagerPageState extends State<VehicleManagerPage> {
  List<Vehicle> vehicles = [];

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
        children: [
          _AddSection(
            onVehicleAdded: (vehicle) {
              setState(() {
                vehicles.add(
                  vehicle,
                );
              });
            },
          ),
          const Text('Vehicle list :'),
          Expanded(
            child: ListView.separated(
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
                      setState(() {
                        vehicles.removeAt(index);
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
            ),
          ),
        ],
      ),
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

class _AddSection extends ConsumerStatefulWidget {
  const _AddSection({
    Key? key,
    required this.onVehicleAdded,
  }) : super(key: key);

  final void Function(Vehicle vehicle) onVehicleAdded;

  @override
  ConsumerState<_AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends ConsumerState<_AddSection> {
  String name = '';
  String year = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final showAddSection = ref.watch(showAddSectionProvider);

    if (!showAddSection) {
      return const SizedBox();
    }
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
              setState(() {
                name = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Year',
            ),
            onChanged: (value) {
              setState(() {
                year = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          AppButton(
            text: 'Add',
            onPressed: canAdd
                ? () {
                    final vehicle = Vehicle(
                      id: const Uuid().v1(),
                      name: name,
                      year: year,
                      description: description,
                    );
                    widget.onVehicleAdded(vehicle);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
