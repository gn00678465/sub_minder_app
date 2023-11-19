import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/scroll_sliver.dart';
import '../../providers/providers.dart';

class SubSettings extends ConsumerStatefulWidget {
  const SubSettings({super.key});

  @override
  ConsumerState<SubSettings> createState() => _SubSettings();
}

class _SubSettings extends ConsumerState<SubSettings> {
  @override
  Widget build(BuildContext context) {
    return ScrollSliver(
      largeTitle: const Text('設定'),
      slivers: <Widget>[
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton.filled(
                child: const Text('Theme'),
                onPressed: () {
                  ref.read(darkModeProvider.notifier).state =
                      !ref.read(darkModeProvider.notifier).state;
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
