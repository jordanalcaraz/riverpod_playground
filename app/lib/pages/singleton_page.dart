import 'package:app/markdown_data.dart';
import 'package:app/widgets/app_button.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringProvider = Provider<String>(
  (ref) => 'Hello world',
);

final intProvider = Provider<int>(
  (ref) => 0,
);

final loggerServiceProvider = Provider<LoggerService>(
  (ref) => const LoggerService(),
);

class LoggerService {
  const LoggerService();

  void customPrint(String text) {
    print('Log: $text');
  }
}

final otherServiceProvider = Provider<OtherService>(
  (ref) {
    final loggerService = ref.watch(loggerServiceProvider);
    return OtherService(loggerService: loggerService);
  },
);

class OtherService {
  const OtherService({required this.loggerService});

  final LoggerService loggerService;

  void doSomething(String text) {
    print('From OtherService :');
    loggerService.customPrint(text);
  }
}

class SingletonPage extends StatelessWidget {
  const SingletonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageName: 'SingletonPage',
      filePath: 'lib/pages/singleton_page.dart',
      markdownData: singletonMarkdown,
      child: _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stringValue = ref.watch(stringProvider);
    final intValue = ref.watch(intProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('stringProvider value: $stringValue'),
        Text('intProvider value: $intValue'),
        AppButton(
          onPressed: () {
            final service = ref.read(otherServiceProvider);
            service.doSomething('Log printed by loggerService');
          },
          text: 'Print',
        ),
      ],
    );
  }
}
