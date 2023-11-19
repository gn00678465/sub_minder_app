import 'package:flutter/cupertino.dart';

class BlurGlassSliverNavBar extends StatefulWidget {
  const BlurGlassSliverNavBar({
    super.key,
    required this.scrollController,
    this.largeTitle,
    this.leading,
    this.trailing,
    this.middle,
    this.previousPageTitle,
    this.alwaysShowMiddle = true,
    this.color = CupertinoColors.white,
    this.darkColor = CupertinoColors.black,
  });

  final ScrollController scrollController;
  final Widget? leading;
  final Widget? trailing;
  final Widget? largeTitle;
  final bool alwaysShowMiddle;
  final String? previousPageTitle;
  final Widget? middle;
  final Color color;
  final Color darkColor;

  @override
  State<BlurGlassSliverNavBar> createState() => _BlurGlassSliverNavBar();
}

class _BlurGlassSliverNavBar extends State<BlurGlassSliverNavBar> {
  final _threshold = 52;
  bool _isCollapsed = false;

  Widget? get leading => widget.leading;
  Widget? get trailing => widget.trailing;
  Widget? get largeTitle => widget.largeTitle;
  bool get alwaysShowMiddle => widget.alwaysShowMiddle;
  String? get previousPageTitle => widget.previousPageTitle;
  Widget? get middle => widget.middle;
  ScrollController get scrollController => widget.scrollController;

  void _scrollHandler() {
    if (scrollController.offset >= _threshold && !_isCollapsed) {
      setState(() {
        _isCollapsed = true;
      });
    } else if (scrollController.offset < _threshold && _isCollapsed) {
      setState(() {
        _isCollapsed = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollHandler);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(_scrollHandler);
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.maybeBrightnessOf(context) == Brightness.dark;

    return CupertinoSliverNavigationBar(
      leading: leading,
      largeTitle: largeTitle,
      trailing: trailing,
      alwaysShowMiddle: alwaysShowMiddle,
      middle: middle,
      previousPageTitle: previousPageTitle,
      stretch: true,
      backgroundColor: _isCollapsed
          ? isDark
              ? const Color.fromRGBO(45, 45, 45, 0.5)
              : CupertinoColors.white.withOpacity(0.5)
          : const _SpecialColor(),
      border: Border(
        bottom: BorderSide(
          width: 0.0,
          color: isDark
              ? CupertinoColors.white.withOpacity(0.5)
              : CupertinoColors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}

class ScrollSliver extends StatelessWidget {
  ScrollSliver({
    super.key,
    this.largeTitle,
    this.leading,
    this.trailing,
    this.navbarPadding,
    this.middle,
    this.previousPageTitle,
    this.alwaysShowMiddle = true,
    this.slivers = const [],
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget? largeTitle;
  final EdgeInsetsDirectional? navbarPadding;
  final bool alwaysShowMiddle;
  final String? previousPageTitle;
  final Widget? middle;
  final List<Widget> slivers;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        BlurGlassSliverNavBar(
          scrollController: scrollController,
          leading: leading,
          trailing: trailing,
          largeTitle: largeTitle,
          alwaysShowMiddle: alwaysShowMiddle,
          previousPageTitle: previousPageTitle,
          middle: middle,
        ),
        ...slivers,
      ],
    );
  }
}

class _SpecialColor extends Color {
  const _SpecialColor() : super(0x00000000);

  @override
  int get alpha => 0xFF;
}
