import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import './services/local_notification.dart';
import './providers/providers.dart';
import './providers/currenciesProvider.dart';
import './routes/router.dart';

void runWithAppConfig() async {
  final NotificationHelper localNotification = NotificationHelper();

  await _configureLocalTimeZone();
  await localNotification.initialNotification();
  await localNotification.requestPermission();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const _EagerInitialization(child: App()),
  ));
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) return;
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    final res = ref.watch(currenciesProvider);
    debugPrint(res.map((e) => e.toJson()).toList().toString());
    return child;
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(darkModeProvider);
    return CupertinoApp.router(
      title: 'Sub Minder',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        barBackgroundColor: const CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.darkBackgroundGray,
        ),
        scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        textTheme: const CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            inherit: false,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            fontFamily: 'GenSenRounded',
            color: CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.black, darkColor: CupertinoColors.white),
            letterSpacing: 1.05,
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'GenSenRounded',
            color: CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.black, darkColor: CupertinoColors.white),
          ),
        ),
      ),
      routeInformationProvider: AppRouter().router.routeInformationProvider,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}

// class MyHomePage extends ConsumerStatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   ConsumerState<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends ConsumerState<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: SliverLayout(
//         largeTitle: Text('Sliver Text'),
//         slivers: [
//           SliverFillRemaining(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Content'),
//                 CupertinoButton.filled(
//                   child: Text('Theme mode'),
//                   onPressed: () {
//                     ref.read(darkModeProvider.notifier).state =
//                         !ref.read(darkModeProvider.notifier).state;
//                   },
//                 ),
//                 Text('Footer'),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
