/// String, DateTime, and other extensions.
extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;
}

extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
