import 'package:flutter/cupertino.dart';

Future openSubManager(BuildContext context) async {
  return Navigator.of(context, rootNavigator: true).push(
    CupertinoPageRoute(
      builder: (context) {
        return const SubManagerEdit();
      },
    ),
  );
}

class SubManagerEdit extends StatelessWidget {
  const SubManagerEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Edit'),
        previousPageTitle: '取消',
        trailing: CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: const Text('確定'),
          onPressed: () {},
        ),
      ),
      child: Center(
        child: CupertinoButton.filled(
          child: Text('Edit page'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
    );
  }
}
