import 'package:intl/intl.dart';

class DateConverter {
  static String toPersian(int year, int month, int day) {
    // اینجا باید الگوریتم تبدیل میلادی به شمسی پیاده شود
    // برای نمونه از یک کتابخانه ساده استفاده می‌کنیم
    // در عمل می‌توان از package:jalali استفاده کرد
    return '$year/$month/$day';
  }

  static String toHijri(int year, int month, int day) {
    // الگوریتم تبدیل میلادی به قمری (ساده)
    return '$year/$month/$day';
  }

  static String getShamsiToday() {
    final now = DateTime.now();
    // اینجا تبدیل میلادی امروز به شمسی
    return '۱۴۰۴/۰۱/۰۱'; // نمونه
  }

  static String getHijriToday() {
    return '۱۴۴۶/۰۷/۰۱'; // نمونه
  }

  static String getGregorianToday() {
    final now = DateTime.now();
    return DateFormat('yyyy/MM/dd').format(now);
  }

  static String getWeekdayShamsi(DateTime date) {
    // تبدیل روز هفته به فارسی
    const weekdays = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه'];
    // اینجا باید روز هفته را بر اساس تاریخ شمسی محاسبه کرد
    return weekdays[date.weekday % 7];
  }
}