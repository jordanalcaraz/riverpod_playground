import 'package:app/pages/practical_work/vehicle_manager_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarWidget extends ConsumerWidget with PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAddSection = ref.watch(showAddSectionProviderProvider);
    return AppBar(
      title: Text(title),
      actions: [
        if (showAddSection)
          IconButton(
            onPressed: () {
              ref.read(showAddSectionProviderProvider.notifier).update((state) => false);
            },
            icon: const Icon(Icons.close),
          )
        else
          IconButton(
            onPressed: () {
              ref.read(showAddSectionProviderProvider.notifier).update((state) => true);
            },
            icon: const Icon(Icons.add),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
