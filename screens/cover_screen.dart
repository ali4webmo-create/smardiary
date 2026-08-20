import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_service.dart';
import '../themes/leather_theme.dart';
import 'home_screen.dart';

class CoverScreen extends StatefulWidget {
  const CoverScreen({Key? key}) : super(key: key);

  @override
  State<CoverScreen> createState() => _CoverScreenState();
}

class _CoverScreenState extends State<CoverScreen> {
  bool _isLoading = false;

  Future<void> _selectDatabase() async {
    setState(() => _isLoading = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        await DatabaseService.importDatabaseFromFile(filePath);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('database_path', DatabaseService.db.path);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => HomeScreen(dbPath: DatabaseService.db.path)),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا در انتخاب دیتابیس: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_leather.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // قاب دوخت داخلی
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: LeatherTheme.stitch, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            // بند چرمی سمت راست
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/strap.png',
                fit: BoxFit.cover,
                width: 40,
              ),
            ),
            // دکمه فلزی
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: Image.asset(
                'assets/images/btn_metal.png',
                width: 60,
                height: 60,
              ),
            ),
            // محتوای مرکزی
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'سررسید هوشمند',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: LeatherTheme.gold,
                      shadows: [
                        Shadow(blurRadius: 10, color: Colors.black.withOpacity(0.5))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'نسخه اندروید',
                    style: TextStyle(
                      fontSize: 18,
                      color: LeatherTheme.paperCream,
                    ),
                  ),
                  const SizedBox(height: 80),
                  LeatherButton(
                    text: _isLoading ? 'در حال بارگذاری...' : 'ورود / انتخاب دیتابیس',
                    onPressed: _isLoading ? null : _selectDatabase,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'لطفاً فایل dbase.db را از حافظه انتخاب کنید',
                    style: TextStyle(
                      fontSize: 14,
                      color: LeatherTheme.textDim,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}