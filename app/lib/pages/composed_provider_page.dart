import 'package:app/markdown_data.dart';
import 'package:app/widgets/app_button.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dependency injection
final service1Provider = Provider<Service1>(
  (ref) => const Service1(),
);

class Service1 {
  const Service1();
}

final service2Provider = Provider<Service2>(
  (ref) => const Service2(),
);

class Service2 {
  const Service2();
}

final service3Provider = Provider<Service3>(
  (ref) {
    return Service3(
      service1: ref.watch(service1Provider),
      service2: ref.watch(service2Provider),
    );
  },
);

class Service3 {
  const Service3({
    required this.service1,
    required this.service2,
  });

  final Service1 service1;
  final Service2 service2;
}

// Combine data
final firstNameProvider = StateProvider<String>(
  (ref) => '',
);

final lastNameProvider = StateProvider<String>(
  (ref) => '',
);

final fullNameProvider = Provider<String>(
  (ref) {
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    return '$firstName $lastName'.trim();
  },
);

class ComposedProviderPage extends StatelessWidget {
  const ComposedProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageName: 'ComposedProviderPage',
      filePath: 'lib/pages/composed_provider_page.dart',
      markdownData: composedProviderMarkdown,
      child: _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullName = ref.watch(fullNameProvider);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('First name :'),
          TextField(
            onChanged: (value) {
              ref.read(firstNameProvider.notifier).state = value;
            },
          ),
          const SizedBox(height: 16),
          const Text('Last name :'),
          TextField(
            onChanged: (value) {
              ref.read(lastNameProvider.notifier).state = value;
            },
          ),
          const SizedBox(height: 16),
          Text('Full name : $fullName'),
          const SizedBox(height: 16),
          const _ValidateButton(),
        ],
      ),
    );
  }
}

final canValidateProvider = StateProvider<bool>(
  (ref) {
    final fullName = ref.watch(fullNameProvider);
    return fullName.isNotEmpty;
  },
);

class _ValidateButton extends ConsumerWidget {
  const _ValidateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canValidate = ref.watch(canValidateProvider);
    // final canValidateWithSelect = ref.watch(fullNameProvider.select((value) => value.isNotEmpty));
    return AppButton(
      onPressed: canValidate ? () {} : null,
      // onPressed: canValidateWithSelect ? () {} : null,
      text: 'Validate',
    );
  }
}
