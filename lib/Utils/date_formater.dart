import 'package:intl/intl.dart';

String formatDateIndonesian(String dateString) {
  // Parse the input date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Create a DateFormat instance for Indonesian locale
  DateFormat formatter = DateFormat('dd MMMM yyyy');

  // Format the DateTime object according to the desired format
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}
