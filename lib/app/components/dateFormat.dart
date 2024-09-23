import 'package:intl/intl.dart';

String formatDate(String isoDateString) {
  // Parse the ISO 8601 date string to a DateTime object
  DateTime dateTime = DateTime.parse(isoDateString);

  // Create a DateFormat with the desired output format
  DateFormat dateFormat = DateFormat("EEEE, dd MMMM yyyy, HH:mm", "id_ID");

  // Format the DateTime object to the localized string
  return dateFormat.format(dateTime);
}