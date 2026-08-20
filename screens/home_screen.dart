import 'package:flutter/material.dart';
import '../widgets/date_header.dart';
import '../widgets/paper_card.dart';
import '../widgets/leather_button.dart';
import '../themes/leather_theme.dart';
import 'memories_screen.dart';
import 'news_screen.dart';
import 'tasks_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String dbPath;
  const HomeScreen({Key? key, required this.dbPath}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DashboardScreen(),
      const MemoriesScreen(),
      const NewsScreen(),
      const TasksScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LeatherTheme.backgroundDark,
      body: Column(
        children: [
          const DateHeader(),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: LeatherTheme.leatherDark,
        selectedItemColor: LeatherTheme.gold,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'خاطرات'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'اخبار'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'وظایف'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'تنظیمات'),
        ],
      ),
    );
  }
}

// ===== صفحه داشبورد (نمونه) =====
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PaperCard(
            title: 'خلاصه امروز',
            child: Text('خاطرات: ۰\nرویدادها: ۰\nوظایف: ۰',
                style: LeatherTheme.bodyText),
          ),
          const SizedBox(height: 12),
          PaperCard(
            title: 'یادآوری‌ها',
            child: Text('هیچ پیگیری ثبت نشده', style: LeatherTheme.bodyText),
          ),
        ],
      ),
    );
  }
}