import 'package:app/router/go_router_builder.dart';
import 'package:app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: const Center(
        child: SingleChildScrollView(
          child: _Layout(),
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          onPressed: () {
            const SingletonRoute().go(context);
          },
          text: 'Singleton',
        ),
        AppButton(
          onPressed: () {
            const StateProviderRoute().go(context);
          },
          text: 'StateProvider',
        ),
        AppButton(
          onPressed: () {
            const ComposedProviderRoute().go(context);
          },
          text: 'Composed Provider',
        ),
        AppButton(
          onPressed: () {
            final id = const Uuid().v1();
            InheritedProviderRoute(id: id).go(context);
          },
          text: 'Inherited Provider',
        ),
        AppButton(
          onPressed: () {
            const VehicleManagerRoute().go(context);
          },
          text: 'Practical Work',
        ),
      ],
    );
  }
}
