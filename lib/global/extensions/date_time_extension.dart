import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  //01/15/2024
  String get formatMMddYYYY => DateFormat('MM/dd/yyyy').format(this);
}
