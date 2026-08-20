import 'package:flutter/material.dart';
import '../services/date_converter.dart';
import '../themes/leather_theme.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shamsi = DateConverter.getShamsiToday();
    final hijri = DateConverter.getHijriToday();
    final gregorian = DateConverter.getGregorianToday();
    final weekday = DateConverter.getWeekdayShamsi(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: LeatherTheme.paperCream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$weekday - $shamsi',
            style: LeatherTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '$hijri | $gregorian',
            style: LeatherTheme.caption,
            textAlign: TextAlign.center,
          ),
          const Divider(color: LeatherTheme.gold, thickness: 1),
        ],
      ),
    );
  }
}