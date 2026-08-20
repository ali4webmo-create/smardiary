import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/cover_screen.dart';
import 'screens/home_screen.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // بررسی وجود دیتابیس
  final prefs = await SharedPreferences.getInstance();
  final dbPath = prefs.getString('database_path');
  runApp(MyApp(dbPath: dbPath));
}

class MyApp extends StatelessWidget {
  final String? dbPath;
  const MyApp({Key? key, this.dbPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سررسید هوشمند',
      theme: ThemeData(
        fontFamily: 'Vazir', // برای فارسی
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa')],
      locale: const Locale('fa'),
      debugShowCheckedModeBanner: false,
      home: dbPath == null ? CoverScreen() : HomeScreen(dbPath: dbPath!),
    );
  }
}