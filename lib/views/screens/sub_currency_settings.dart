import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class CurrencySettings extends ConsumerStatefulWidget {
  const CurrencySettings({super.key});

  @override
  ConsumerState<CurrencySettings> createState() => _CurrencySettings();
}

class _CurrencySettings extends ConsumerState<CurrencySettings> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Edit Currencies'),
      ),
      child: Center(
        child: Text('CurrencySettings'),
      ),
    );
  }
}
