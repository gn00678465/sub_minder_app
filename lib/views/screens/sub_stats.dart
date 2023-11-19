import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/scroll_sliver.dart';

class SubStats extends ConsumerStatefulWidget {
  const SubStats({super.key});

  @override
  ConsumerState<SubStats> createState() => _SubStats();
}

class _SubStats extends ConsumerState<SubStats> {
  @override
  Widget build(BuildContext context) {
    return ScrollSliver(
      largeTitle: const Text('統計數據'),
      slivers: const <Widget>[
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stats'),
            ],
          ),
        ),
      ],
    );
  }
}
