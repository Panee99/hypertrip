import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDateTimeToShortDate(DateTime? date) {
    if (date == null) return '';
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
