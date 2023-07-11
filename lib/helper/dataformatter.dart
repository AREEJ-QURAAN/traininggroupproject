import 'package:flutter/material.dart';

class LocalDateFormat {
  static String format(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    return '$year/$month/$day';
  }
}

class LocalTimeFormat {
  static String format(TimeOfDay time) {
    String hours = time.hour.toString().padLeft(2, '0');
    String mins = time.minute.toString().padLeft(2, '0');
    String timesfx = time.hour > 12 ? 'Pm' : 'Am';
    return '$hours:$mins $timesfx';
  }
}
