import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:system_info_agent/system_info_agent.dart';

import '../../core/providers/theme_provider.dart';
import '../../global.dart';
import '../core/database/share_pref.dart';
import '../core/providers/bottom_navi_index_provider.dart';
import '../core/providers/login_provider.dart';
import '../core/theme/app_theme.dart';
import '../main.dart';
import 'home/main_tab_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationIndexProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        // ChangeNotifierProvider.value(value: ProfileProvider.initialize()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider tm, Widget? child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: tm.themeMode,
            scaffoldMessengerKey: rootScaffoldKey,
            debugShowCheckedModeBanner: false,
            theme: BuildThemeData.lightTheme,
            darkTheme: BuildThemeData.darkTheme,
            title: '',
            home: RootPage(),
          );
        },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await SystemInfoAgent.init();
      initPlatformState();
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = SystemInfoAgent.userAgent!;
      print(platformVersion.toString() + " ========> Platform Version");
      await SharedPref.setData(
        key: SharedPref.user_agent,
        value: platformVersion,
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainTabsPage();
  }
}
