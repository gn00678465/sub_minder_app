import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/main_layout.dart';
import './sub_manager.dart';
import './sub_settings.dart';
import './sub_stats.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      keepAlive: true,
      tabBar: CupertinoTabBar(
        currentIndex: ref.watch(_pageProvider),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: '管理',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_alt_fill),
            label: '統計',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt_fill),
            label: '設定',
          ),
        ],
        onTap: (int index) {
          ref.read(_pageProvider.notifier).state = index;
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (context) {
            return switch (index) {
              0 => const SubManager(
                  key: ValueKey('SubManger'),
                ),
              1 => const SubStats(
                  key: ValueKey('SubStats'),
                ),
              2 => const SubSettings(
                  key: ValueKey('SubSettings'),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        );
      },
    );
  }
}

final _pageProvider = StateProvider<int>((ref) => 0);
