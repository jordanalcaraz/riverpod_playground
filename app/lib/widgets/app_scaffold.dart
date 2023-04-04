import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

final _showExplanationsProvider = StateProvider.family<bool, String>(
  (ref, pageName) => true,
);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.pageName,
    required this.filePath,
    required this.child,
    required this.markdownData,
  }) : super(key: key);

  final String pageName;
  final String filePath;
  final Widget child;
  final String markdownData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: [
          _AppBarButton(
            pageName: pageName,
          ),
        ],
      ),
      body: _Body(
        filePath: filePath,
        markdownData: markdownData,
        pageName: pageName,
        child: child,
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
    required this.child,
    required this.filePath,
    required this.markdownData,
    required this.pageName,
  }) : super(key: key);

  final Widget child;
  final String filePath;
  final String markdownData;
  final String pageName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showExplanations = ref.watch(_showExplanationsProvider(pageName));
    if (showExplanations) {
      return Markdown(data: markdownData);
    }

    return WidgetWithCodeView(
      filePath: filePath,
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}

class _AppBarButton extends ConsumerWidget {
  const _AppBarButton({
    Key? key,
    required this.pageName,
  }) : super(key: key);
  final String pageName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showExplanations = ref.watch(_showExplanationsProvider(pageName));
    if (showExplanations) {
      return IconButton(
        tooltip: 'Show code example',
        icon: const Icon(Icons.code),
        onPressed: () {
          ref.read(_showExplanationsProvider(pageName).notifier).state = false;
        },
      );
    }
    return IconButton(
      tooltip: 'Show explanations',
      icon: const Icon(Icons.help),
      onPressed: () {
        ref.read(_showExplanationsProvider(pageName).notifier).state = true;
      },
    );
  }
}
