import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateTimeRepoProvider = Provider<DateTimeRepo>((ref) {
  return DateTimeRepo();
});

class DateTimeRepo {
  String getTimeFormatted(DateTime time) {
    return DateFormat(DateFormat.HOUR_MINUTE, 'ar_SA').format(time);
  }

  String getDayDate(DateTime date) {
    return DateFormat(DateFormat.NUM_MONTH_WEEKDAY_DAY, 'ar_SA').format(date);
  }
}
