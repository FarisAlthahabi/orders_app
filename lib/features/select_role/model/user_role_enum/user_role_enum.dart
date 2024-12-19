import 'package:easy_localization/easy_localization.dart';

enum UserRoleEnum {
  customer,
  driver;

  String get displayName {
    switch (this) {
      case UserRoleEnum.customer:
        return "customer".tr();
      case UserRoleEnum.driver:
        return "driver".tr();
    }
  }
}
