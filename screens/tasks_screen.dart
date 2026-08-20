import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/paper_card.dart';
import '../themes/leather_theme.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final data = await DatabaseService.getFollowUps(isDone: false);
    setState(() => _tasks = data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (ctx, i) {
          final item = _tasks[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: PaperCard(
              title: item['title'],
              child: Text(
                'یادآوری: ${item['remind_date']}',
                style: LeatherTheme.caption,
              ),
            ),
          );
        },
      ),
    );
  }
}