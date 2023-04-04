import 'package:app/markdown_data.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final idGetter = Provider<String>(
  (ref) => throw UnimplementedError(),
);

final scopedUuidProvider = Provider<UuidValue>(
  (ref) {
    final id = ref.watch(idGetter);
    return UuidValue.fromList(Uuid.parse(id));
  },
  dependencies: [
    idGetter,
  ],
);

final familyUuidProvider = Provider.family<UuidValue, String>(
  (ref, id) {
    return UuidValue.fromList(Uuid.parse(id));
  },
);

class InheritedProviderPage extends StatelessWidget {
  const InheritedProviderPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        idGetter.overrideWithValue(id),
      ],
      child: const AppScaffold(
        pageName: 'InheritedProviderPage',
        filePath: 'lib/pages/inherited_provider_page.dart',
        markdownData: inheritedProviderMarkdown,
        child: _Layout(),
      ),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(idGetter);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        Text('id from inherited provider : $id'),
        const SizedBox(height: 32),
        const _ScopedReader(),
        const SizedBox(height: 32),
        const _FamilyReader(),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ScopedReader extends ConsumerWidget {
  const _ScopedReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uuid = ref.watch(scopedUuidProvider);
    final bytes = uuid.toBytes().toString();
    return Text('Bytes from scopedUuidProvider :\n$bytes');
  }
}

class _FamilyReader extends ConsumerWidget {
  const _FamilyReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(idGetter);
    final uuid = ref.watch(familyUuidProvider(id));
    final bytes = uuid.toBytes().toString();
    return Text('Bytes from familyUuidProvider :\n$bytes');
  }
}
