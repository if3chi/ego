import 'package:intl/intl.dart';

class DateService {
  static final DateTime _currentDate = DateTime.now();
  static final DateFormat dateFormat = DateFormat("MMM, E d, yy.");
  static final NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
  static final NumberFormat compactFromat = NumberFormat.compact();

  static DateTime get pastMonth =>
      DateTime(_currentDate.year, _currentDate.month, 0);
  static DateTime get nextMonth =>
      DateTime(_currentDate.year, _currentDate.month + 1, 1);
}
