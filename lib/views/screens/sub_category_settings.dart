import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CategorySettings extends ConsumerStatefulWidget {
  const CategorySettings({super.key});

  @override
  ConsumerState<CategorySettings> createState() => _CategorySettings();
}

class _CategorySettings extends ConsumerState<CategorySettings> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Edit Category'),
      ),
      child: Center(
        child: Text('Edit Category'),
      ),
    );
  }
}
