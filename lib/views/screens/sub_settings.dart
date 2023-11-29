import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/scroll_sliver.dart';
import '../widgets//profile_card.dart';
import '../../providers/settingsProvider.dart';
import './sub_currency_settings.dart';
import './sub_category_settings.dart';

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
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const ProfileCard(),
              ListSection(
                title: '顯示設定',
                children: [
                  CupertinoListTile.notched(
                    title: const Text('夜間模式'),
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: CupertinoColors.systemIndigo,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value:
                          ref.watch(displaySettingsProvider)?.darkMode ?? false,
                      onChanged: (bool? checked) {
                        ref
                            .read(displaySettingsProvider.notifier)
                            .toggleDarkMode();
                      },
                    ),
                  ),
                ],
              ),
              ListSection(
                title: '通知設定',
                children: [
                  CupertinoListTile.notched(
                    title: const Text('啟用通知'),
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: CupertinoColors.systemIndigo,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value:
                          ref.watch(displaySettingsProvider)?.darkMode ?? false,
                      onChanged: (bool? checked) {
                        ref
                            .read(displaySettingsProvider.notifier)
                            .toggleDarkMode();
                      },
                    ),
                  ),
                  const NotificationDaysTile(),
                ],
              ),
              CupertinoListSection.insetGrouped(
                children: [
                  PageRouteTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: CupertinoColors.systemGrey4,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    title: const Text('Categories 設定'),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
                      size: 20,
                      color: CupertinoColors.systemGrey,
                    ),
                    page: const CategorySettings(),
                  ),
                  PageRouteTile(
                    title: const Text('Currencies 設定'),
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: CupertinoColors.systemGrey4,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
                      size: 20,
                      color: CupertinoColors.systemGrey,
                    ),
                    page: const CurrencySettings(),
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            color: CupertinoColors.systemGroupedBackground,
          ),
        ),
      ],
    );
  }
}

class ListSection extends StatelessWidget {
  const ListSection({
    super.key,
    required this.title,
    this.children,
  });

  final String title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      children: children,
    );
  }
}

class NotificationDaysTile extends ConsumerWidget {
  const NotificationDaysTile({super.key});

  Future _showDialog(context, Widget child) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 4),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationSettings = ref.watch(notificationSettingsProvider);
    return CupertinoListTile(
      title: const Text('Pre days notification'),
      onTap: () {
        _showDialog(
          context,
          CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (value) {},
            children: List<Widget>.generate(
              7,
              (index) {
                return Center(child: Text('${index + 1} pre days'));
              },
            ),
          ),
        );
      },
    );
  }
}

class PageRouteTile extends StatelessWidget {
  const PageRouteTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    required this.page,
  });

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      title: title,
      leading: leading,
      trailing: trailing,
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
