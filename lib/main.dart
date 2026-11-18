import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/quran_screen.dart';
import 'screens/adhkar_screen.dart';
import 'screens/games_screen.dart';
import 'screens/library_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const NoorApp());
}

class NoorApp extends StatefulWidget {
  const NoorApp({super.key});
  @override
  State<NoorApp> createState() => _NoorAppState();
}

class _NoorAppState extends State<NoorApp> {
  int index = 0;
  bool dark = false;

  final pages = const [
    HomeScreen(), QuranScreen(), AdhkarScreen(),
    GamesScreen(), LibraryScreen(), SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => dark = prefs.getBool('dark_mode') ?? false);
  }

  Future<void> setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
    setState(() => dark = value);
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF075B46);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نور الإسلامي',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: green),
        scaffoldBackgroundColor: const Color(0xFFF6F8F5),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF6F8F5), foregroundColor: green),
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true, brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF31A886), brightness: Brightness.dark),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: IndexedStack(index: index, children: pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (v) => setState(() => index = v),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
              NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'القرآن'),
              NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'الأذكار'),
              NavigationDestination(icon: Icon(Icons.extension_outlined), label: 'الألعاب'),
              NavigationDestination(icon: Icon(Icons.auto_stories_outlined), label: 'المكتبة'),
              NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'الإعدادات'),
            ],
          ),
        ),
      ),
    );
  }
}
