import 'package:intl/intl.dart';

bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.year == dateTime2.year &&
      dateTime1.month == dateTime2.month &&
      dateTime1.day == dateTime2.day;
}

String? formatDate(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }
  return null;
}

  bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

bool isDateInRange(DateTime date, DateTime start, DateTime end) {
  return date.isAfter(start) && date.isBefore(end);
}
