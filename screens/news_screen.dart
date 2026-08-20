import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/paper_card.dart';
import '../themes/leather_theme.dart';
import '../services/date_converter.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Map<String, dynamic>> _news = [];
  String _today = DateConverter.getShamsiToday();

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    final data = await DatabaseService.getNewsByDate(_today);
    setState(() => _news = data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: _news.length,
        itemBuilder: (ctx, i) {
          final item = _news[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: PaperCard(
              title: item['title'] ?? 'بدون عنوان',
              child: Text(
                item['description'] ?? '',
                style: LeatherTheme.bodyText,
              ),
            ),
          );
        },
      ),
    );
  }
}