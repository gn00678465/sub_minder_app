import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import './router_constant.dart';
import '../views/screens/main_page.dart';
import '../views/screens/init_page.dart';
import '../views/screens/login_page.dart';

class AppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
      name: AppRoutesConstant.homePageName,
      path: '/',
      pageBuilder: (context, state) {
        return CupertinoPage(child: HomePage());
      },
    ),
    GoRoute(
      name: AppRoutesConstant.initPageName,
      path: '/init',
      pageBuilder: (context, state) {
        return const CupertinoPage(child: InitPage());
      },
    ),
    GoRoute(
      name: AppRoutesConstant.loginPageName,
      path: '/login',
      pageBuilder: (context, state) {
        return const CupertinoPage(child: LoginPage());
      },
    ),
  ]);
}
