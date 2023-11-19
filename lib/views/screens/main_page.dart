import 'package:flutter/cupertino.dart';

import './sub_manager.dart';
import './sub_settings.dart';
import './sub_stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
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
        onTap: (int value) {
          _currentPage = value;
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (context) {
            return SubPageView(
              page: _currentPage,
            );
          },
        );
      },
    );
  }
}

class SubPageView extends StatefulWidget {
  const SubPageView({
    super.key,
    required this.page,
  });

  final int page;

  @override
  State<SubPageView> createState() => _SubPageView();
}

class _SubPageView extends State<SubPageView> {
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.page, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          children: const [
            SubManager(),
            SubStats(),
            SubSettings(),
          ],
        ),
      ],
    );
  }
}
