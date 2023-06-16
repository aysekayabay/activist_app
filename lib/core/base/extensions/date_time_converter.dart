import 'package:intl/intl.dart';

extension DateConverter on String {
  String get formattedDate {
    DateTime _inputDate = DateTime.parse(this);
    return DateFormat("d MMMM y", "tr_TR").format(_inputDate);
  }

  String get formattedTime {
    DateTime _inputDate = DateTime.parse(this);
    return DateFormat.Hm().format(_inputDate);
  }
}
