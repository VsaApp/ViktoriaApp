import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

export 'aixformation.dart';
export 'cafetoria_model.dart';
export 'calendar_model.dart';
export 'keys.dart';
export 'selection.dart';
export 'subject_row_details.dart';
export 'substitution_plan_model.dart';
export 'tags_model.dart';
export 'times.dart';
export 'timetable_model.dart';
export 'updates_model.dart';
export 'user.dart';

/// Http status codes
class StatusCodes {
  // ignore: public_member_api_docs
  static int get success => 200;

  // ignore: public_member_api_docs
  static int get timeout => 408;

  // ignore: public_member_api_docs
  static int get notFound => 404;

  // ignore: public_member_api_docs
  static int get unauthorized => 401;

  // ignore: public_member_api_docs
  static int get offline => -1;

  // ignore: public_member_api_docs
  static int get failed => -100;
}

/// List of all grades
List<String> grades = [
  '5a',
  '5b',
  '5c',
  '6a',
  '6b',
  '6c',
  '7a',
  '7b',
  '7c',
  '8a',
  '8b',
  '8c',
  '9a',
  '9b',
  '9c',
  'ef',
  'q1',
  'q2',
];

/// Check if a grade is a senior grade
bool isSeniorGrade(String grade) => grades.indexOf(grade) > 14;

/// List of all weekdays
Map<int, String> weekdays = {
  0: 'Montag',
  1: 'Dienstag',
  2: 'Mittwoch',
  3: 'Donnerstag',
  4: 'Freitag',
  5: 'Samstag',
  6: 'Sonntag',
};

/// List of all months
Map<int, String> months = {
  0: 'Januar',
  1: 'Februar',
  2: 'März',
  3: 'April',
  4: 'Main',
  5: 'Juni',
  6: 'Juli',
  7: 'August',
  8: 'September',
  9: 'Oktober',
  10: 'November',
  11: 'Dezember',
};

/// The date format to display all dates in
DateFormat outputDateFormat = DateFormat('dd.MM.y');

/// The date and time format to display all dates and times in
DateFormat outputDateTimeFormat = DateFormat('dd.MM.y HH:mm');

var _dateFormats = [];

/// Setup all date formats used by the web server
Future setupDateFormats() async {
  await initializeDateFormatting('de', null);
  _dateFormats = [
    DateFormat.yMMMMd('de'),
    outputDateFormat,
  ];
}

/// Parse a date using any format used by the server
DateTime parseDate(String date) {
  for (final format in _dateFormats.cast<DateFormat>()) {
    try {
      try {
        if (format.parse(date).year < 2000) {
          date =
              '${date.split('.')[0]}.${date.split('.')[1]}.${(int.parse(date.split('.')[2]) + 2000).toString()}';
        }
        // ignore: empty_catches
      } on Exception {}

      return format.parse(date);
      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }
  throw FormatException('$date was not matching any date formats');
}

/// Get the week number of a year by date
int weekNumber(DateTime date) {
  final dayOfYear = int.parse(DateFormat('D').format(date));
  return ((dayOfYear - date.weekday + 10) / 7).floor();
}

/// Get the Monday of the week
/// Skips to next week when weekend
DateTime monday(DateTime date) {
  var newDate = date.subtract(Duration(
    days: date.weekday - 1,
    hours: date.hour,
    minutes: date.minute,
    seconds: date.second,
    milliseconds: date.millisecond,
    microseconds: date.microsecond,
  ));
  newDate = newDate.add(Duration(days: date.weekday > 5 ? 7 : 0));
  // Daylight saving time lol
  if (newDate.hour == 23) {
    newDate = newDate.add(Duration(hours: 1));
  }
  return newDate;
}
