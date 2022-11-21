import 'package:intl/intl.dart';

var addCommaToString = NumberFormat("###,###.0#", "en_US");

extension dateExt on String {
  String get toDate {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("yMMMd");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  double get toDouble {
    return double.tryParse(this) ?? 0.0;
  }

  String get toTime {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("jm");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension dateFormated on String {
  String get toDateFormted {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }
}
