import 'package:intl/intl.dart';

String formatDateTime(String isoTime) {
  final DateTime dateTime = DateTime.parse(isoTime);
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
  return formatter.format(dateTime);
}

String formatDateOnly(String isoTime) {
  final DateTime dateTime = DateTime.parse(isoTime);
  final DateFormat formatter = DateFormat('dd-MM-yyyy ');
  return formatter.format(dateTime);
}

