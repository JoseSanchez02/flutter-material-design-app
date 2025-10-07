import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Material App',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      themeMode: _themeProvider.themeMode,

      // Home screen
      home: const HomeScreen(),

      // Material Design configuration
      builder: (context, child) {
        return MediaQuery(
          // Ensure text scale factor doesn't exceed accessibility limits
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.5)),
          ),
          child: child!,
        );
      },
    );
  }
}
