import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';

enum DrawerTileEnum {
  settings,
  logout;

  String get displayName {
    switch (this) {
      case DrawerTileEnum.settings:
        return "settings".tr();
      case DrawerTileEnum.logout:
        return "logout".tr();
    }
  }

  Color get color {
    if (this == DrawerTileEnum.logout) {
      return AppColors.red;
    } else {
      return AppColors.black;
    }
  }

  IconData get icon {
    switch (this) {
      case DrawerTileEnum.settings:
        return Icons.settings_outlined;
      case DrawerTileEnum.logout:
        return Icons.logout_outlined;
    }
  }

  VoidCallback action(BuildContext context) {
    switch (this) {
      case DrawerTileEnum.settings:
        return () => context.router.push(SettingsRoute());

      case DrawerTileEnum.logout:
        return (){};
    }
  }
}
