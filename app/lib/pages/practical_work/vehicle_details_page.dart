import 'package:app/pages/practical_work/vehicle_manager_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return _Layout(
      vehicleId: vehicleId,
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VehicleDetailsPage')),
      body: _Body(vehicleId: vehicleId),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IdText(vehicleId: vehicleId),
          _NameText(vehicleId: vehicleId),
          _YearText(vehicleId: vehicleId),
          _DescriptionText(vehicleId: vehicleId),
        ],
      ),
    );
  }
}

class _IdText extends StatelessWidget {
  const _IdText({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return Text('id: $vehicleId');
  }
}

class _NameText extends StatelessWidget {
  const _NameText({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    final vehicle = currentVehicles.firstWhereOrNull((element) => element.id == vehicleId);
    return Text('name: ${vehicle?.name}');
  }
}

class _YearText extends StatelessWidget {
  const _YearText({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    final vehicle = currentVehicles.firstWhereOrNull((element) => element.id == vehicleId);
    return Text('year: ${vehicle?.year}');
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText({Key? key, required this.vehicleId}) : super(key: key);

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    final vehicle = currentVehicles.firstWhereOrNull((element) => element.id == vehicleId);
    return Text('description: ${vehicle?.description}');
  }
}
