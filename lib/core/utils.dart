import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

getTime(String dateString) {
  DateTime sentDate = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  Duration timeElapsed = now.difference(sentDate);

  // Calculate time elapsed in days, hours, minutes, etc.
  int days = timeElapsed.inDays;
  int hours = timeElapsed.inHours.remainder(24);
  int minutes = timeElapsed.inMinutes.remainder(60);

  // Format the output based on the elapsed time and locale
  String timeAgo;
  if (days > 0) {
    timeAgo = "$days day${days > 1 ? 's' : ''} ago";
  } else if (hours > 0) {
    timeAgo = "$hours hour${hours > 1 ? 's' : ''} ago";
  } else if (minutes > 0) {
    timeAgo = "$minutes minute${minutes > 1 ? 's' : ''} ago";
  } else {
    timeAgo = "now";
  }

  return timeAgo;
}

String getRfc3339ZuluTimestamp() {
  DateTime now = DateTime.now().toUtc(); // Get current time in UTC
  return '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSSSSS').format(now)}Z'; // Format with nanosecond resolution and "Z" for Zulu
}

bool isDifferenceOneYear(Timestamp startTimestamp, Timestamp endTimestamp) {
  // Convert Firestore Timestamps to Dart DateTime
  DateTime startDate = startTimestamp.toDate();
  DateTime endDate = endTimestamp.toDate();

  // Calculate the difference in days
  Duration difference = endDate.difference(startDate);

  // Get the difference in years using the Duration's days property
  int differenceInYears = difference.inDays ~/ 365;

  // Check if the difference is approximately one year
  // Considering leap years, we check for a range of 365 to 366 days
  if (differenceInYears >= 1 || difference.inDays >= 365) {
    return true;
  }
  return false;
}

bool isSubscribed(Timestamp? subscriptionDate){
  return subscriptionDate != null && !isDifferenceOneYear(subscriptionDate, Timestamp.now());
}