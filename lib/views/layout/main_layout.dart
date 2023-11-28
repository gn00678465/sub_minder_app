import 'package:flutter/cupertino.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
    required this.tabBar,
    required this.tabBuilder,
    this.controller,
    this.keepAlive = false,
    this.backgroundColor,
  });

  final CupertinoTabBar tabBar;
  final Widget Function(BuildContext, int) tabBuilder;
  final CupertinoTabController? controller;
  final bool keepAlive;
  final Color? backgroundColor;

  @override
  State<MainLayout> createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoTabScaffold(
      controller: widget.controller,
      tabBar: widget.tabBar,
      tabBuilder: widget.tabBuilder,
      backgroundColor: widget.backgroundColor,
    );
  }
}
