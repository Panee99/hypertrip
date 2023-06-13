import 'package:flutter/material.dart';
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

  static String getVerboseDateTimeRepresentation(BuildContext context, DateTime? dateTime,
      {bool timeOnly = false}) {
    if (dateTime == null) return '';

    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return "Just now";
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (timeOnly ||
        (localDateTime.day == now.day &&
            localDateTime.month == now.month &&
            localDateTime.year == now.year)) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return "Yesterday";
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday =
          DateFormat('E', Localizations.localeOf(context).toLanguageTag()).format(localDateTime);

      return '$weekday, $roughTimeString';
    }

    return '${DateFormat('yMMMd', Localizations.localeOf(context).toLanguageTag()).format(dateTime)}';
  }
}
