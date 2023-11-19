import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/scroll_sliver.dart';
import './sub_manager_edit.dart';

class SubManager extends ConsumerStatefulWidget {
  const SubManager({super.key});

  @override
  ConsumerState<SubManager> createState() => _SubManager();
}

class _SubManager extends ConsumerState<SubManager> {
  @override
  Widget build(BuildContext context) {
    return ScrollSliver(
      largeTitle: const Text('訂閱管理'),
      trailing: CupertinoButton(
        child: const Icon(
          CupertinoIcons.add,
        ),
        onPressed: () {
          openSubManager(context);
        },
      ),
      slivers: const <Widget>[
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Manger'),
            ],
          ),
        ),
      ],
    );
  }
}
