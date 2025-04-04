import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeStr on DateTime {
  String toyyyyMMddTHHmmss() {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  String toyyyyMMddTHHmmss2() {
    return DateFormat('yyyy-MM-dd-HHmmss').format(this);
  }

  String toEEEdMMM() {
    return DateFormat('EEE, dd MMM').format(this);
  }

  String toEEEEdMMM() {
    return DateFormat('EEEE, dd MMM').format(this);
  }

  String toEEEdMMMyyyy() {
    return DateFormat('EEE, dd MMM yyyy').format(this);
  }

  String toddMMMyyyyWithOutComma() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String toddMMM() {
    return DateFormat('dd MMM').format(this);
  }

  String todd() {
    return DateFormat('dd').format(this);
  }

  String tom() {
    return DateFormat('MMM').format(this);
  }

  String toEEE() {
    return DateFormat('EEE').format(this);
  }

  String todMMM() {
    return DateFormat('d MMM').format(this);
  }

  String toddMMMyyyy() {
    return DateFormat('dd MMM, yyyy').format(this);
  }

  String toHm() {
    return DateFormat.Hm().format(this);
  }

  String toyyyyMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toMMMy() {
    return DateFormat('MMM-yyyy').format(this);
  }

  String toMMMyy() {
    return DateFormat('MMM yyyy').format(this);
  }

  String toMM() {
    return DateFormat('MM').format(this);
  }

  Duration differenceFromToday() {
    final now = DateTime.now();

    return difference(now);
  }

  int daysRemaining() {
    return differenceFromToday().inDays;
  }

  DateTime trimTillSeconds() => DateTime(year, month, day, hour, minute);
  DateTime get sliceAwayTime => DateTime(year, month, day);

  bool isDateSame(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  int getAge() {
    final today = DateTime.now();

    if (isAfter(today)) {
      return 0;
    }
    int age = today.year - year;
    final m = today.month - month;
    if (m < 0 || (m == 0 && today.day < day)) {
      /// if month difference is less than zero if not month difference is zero and today is  before  dob day, decrement age by one

      age--;
    }
    return age;
  }

  DateTime addCurrentTimeToDate() {
    final now = DateTime.now();

    return DateTime(year, month, day, now.hour, now.minute, now.second);
  }

  DateTime getCurrentDateOrFutureDate() {
    final now = DateTime.now();
    if (now.isBefore(this)) {
      return this;
    }
    return now;
  }
}

extension DurationExtension on Duration {
  String getDurationInString() {
    String hrsText = inHours > 0 ? '${inHours}hr ' : '';
    String minText =
        inMinutes.remainder(60) > 0 ? '${inMinutes.remainder(60)}min' : '';
    return "$hrsText$minText";
  }

  String getDurationMinSecInString() {
    String minText = inMinutes > 0 ? '${inMinutes}min ' : '';
    String secText =
        inSeconds.remainder(60) > 0 ? '${inSeconds.remainder(60)}sec' : '';

    return "$minText$secText";
  }
}

extension TimeOfDayExtension on TimeOfDay {
  DateTime convertToDateTime(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hour,
      minute,
    );
  }
}
