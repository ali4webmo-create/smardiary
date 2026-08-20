import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_service.dart';
import '../widgets/leather_button.dart';
import '../themes/leather_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _changeDatabase() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'],
    );
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      await DatabaseService.importDatabaseFromFile(path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('database_path', DatabaseService.db.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('دیتابیس با موفقیت تغییر کرد')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تنظیمات', style: LeatherTheme.titleLarge),
          const SizedBox(height: 20),
          LeatherButton(
            text: 'تغییر دیتابیس',
            onPressed: _changeDatabase,
          ),
          const SizedBox(height: 12),
          LeatherButton(
            text: 'خروج از برنامه',
            onPressed: () => Navigator.popUntil(context, (route) => false),
          ),
        ],
      ),
    );
  }
}