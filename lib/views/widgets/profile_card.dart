import 'package:flutter/cupertino.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      children: [
        CupertinoListTile(
          title: const Text(
            'User Name',
            style: TextStyle(fontSize: 20, height: 1.2),
          ),
          subtitle: const Text('Sub title'),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leadingSize: 60,
          leading: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.systemGrey4,
            ),
          ),
          trailing: const Icon(
            CupertinoIcons.right_chevron,
            size: 20,
            color: CupertinoColors.systemGrey,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
