import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum DriverNavigationBarEnum {
  home,
  cart;

  String displayName() {
    switch (this) {
      case DriverNavigationBarEnum.home:
        return "home".tr();
      case DriverNavigationBarEnum.cart:
        return "orders".tr();
    }
  }

  IconData icon() {
    switch (this) {
      case DriverNavigationBarEnum.home:
        return Icons.home_outlined;
      case DriverNavigationBarEnum.cart:
        return Icons.shopping_cart_outlined;
    }
  }
}
