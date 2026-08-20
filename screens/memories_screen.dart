import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/paper_card.dart';
import '../widgets/leather_button.dart';
import '../themes/leather_theme.dart';
import '../services/date_converter.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({Key? key}) : super(key: key);

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  List<Map<String, dynamic>> _memories = [];
  final TextEditingController _controller = TextEditingController();
  String _today = DateConverter.getShamsiToday();

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  Future<void> _loadMemories() async {
    final data = await DatabaseService.getMemoriesByDate(_today);
    setState(() => _memories = data);
  }

  Future<void> _addMemory() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    await DatabaseService.insert('daily_memories', {
      'date_shamsi': _today,
      'content': content,
    });
    _controller.clear();
    await _loadMemories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'متن خاطره...',
                    filled: true,
                    fillColor: LeatherTheme.paperCream,
                    border: OutlineInputBorder(),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(width: 8),
              LeatherButton(text: 'ثبت', onPressed: _addMemory),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _memories.length,
              itemBuilder: (ctx, i) {
                final item = _memories[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: PaperCard(
                    child: Text(item['content'], style: LeatherTheme.bodyText),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}