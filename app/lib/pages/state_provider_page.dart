import 'package:app/markdown_data.dart';
import 'package:app/widgets/app_button.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boolProvider = StateProvider<bool>(
  (ref) => false,
);

final countProvider = StateProvider<int>(
  (ref) => 0,
);

final modifierServiceProvider = Provider<ModifierService>(
  (ref) {
    return ModifierService(ref: ref);
  },
);

class ModifierService {
  const ModifierService({required this.ref});

  final Ref ref;

  void incrementValue() {
    final canIncrement = ref.read(boolProvider);
    if (canIncrement) {
      ref.read(countProvider.notifier).state++;
    }
  }
}

class StateProviderPage extends StatelessWidget {
  const StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageName: 'StateProviderPage',
      filePath: 'lib/pages/state_provider_page.dart',
      markdownData: stateProviderMarkdown,
      child: _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    final boolValue = ref.watch(boolProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          onPressed: () {
            final value = ref.read(countProvider);
            ref.read(countProvider.notifier).state = value + 1;
          },
          text: 'Count: $count (value + 1)',
        ),
        AppButton(
          onPressed: () {
            ref.read(countProvider.notifier).state++;
          },
          text: 'Count: $count (++)',
        ),
        AppButton(
          onPressed: () {
            ref.read(countProvider.notifier).update((state) => state + 1);
          },
          text: 'Count: $count (update)',
        ),
        Checkbox(
          value: boolValue,
          onChanged: (value) {
            ref.read(boolProvider.notifier).state = value ?? false;
          },
        ),
        AppButton(
          onPressed: () {
            ref.read(boolProvider.notifier).update((state) => !state);
          },
          text: 'Inverse bool with update',
        ),
        AppButton(
          onPressed: () {
            ref.read(modifierServiceProvider).incrementValue();
          },
          text: 'Increment if true',
        ),
      ],
    );
  }
}
