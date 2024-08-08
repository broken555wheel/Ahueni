import 'package:intl/intl.dart';

class SoberDays {
  DateTime startDate;
  late int daysElapsed;

  SoberDays({required this.startDate})
      : daysElapsed = _calculateDaysElapsed(startDate);

  factory SoberDays.withToday() {
    DateTime today = DateTime.now();
    return SoberDays(startDate: today);
  }

  void updateStartDate(DateTime newDate) {
    startDate = newDate;
    daysElapsed = _calculateDaysElapsed(startDate);
  }

  static int _calculateDaysElapsed(DateTime startDate) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(startDate);
    return difference.inDays;
  }

  String getFormattedStartDate() {
    return DateFormat('dd-MM-yyyy').format(startDate);
  }

  void updateCounter() {
    daysElapsed = _calculateDaysElapsed(startDate);
  }

  int get getDaysElapsed => daysElapsed;

}
