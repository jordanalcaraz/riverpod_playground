import 'package:app/router/go_router_builder.dart';
import 'package:app/widgets/app_button.dart';
import 'package:flutter/material.dart';
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

class VehicleManagerPage extends StatefulWidget {
  const VehicleManagerPage({Key? key}) : super(key: key);

  @override
  State<VehicleManagerPage> createState() => _VehicleManagerPageState();
}

class _VehicleManagerPageState extends State<VehicleManagerPage> {
  List<Vehicle> vehicles = [];
  bool showAddSection = false;

  String name = '';
  String year = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final canAdd = name.isNotEmpty && yearIsValid(year);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PracticalWork'),
        actions: [
          if (showAddSection)
            IconButton(
              onPressed: () {
                setState(() {
                  showAddSection = false;
                });
              },
              icon: const Icon(Icons.close),
            )
          else
            IconButton(
              onPressed: () {
                setState(() {
                  showAddSection = true;
                });
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: Column(
        children: [
          if (showAddSection)
            Container(
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
                            setState(() {
                              vehicles.add(
                                Vehicle(
                                  id: const Uuid().v1(),
                                  name: name,
                                  year: year,
                                  description: description,
                                ),
                              );
                            });
                          }
                        : null,
                  ),
                ],
              ),
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
