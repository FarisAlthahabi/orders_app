import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum NavigationBarEnum {
  home,
  cart,
  favorite,
  profile;

  String displayName() {
    switch (this) {
      case NavigationBarEnum.home:
        return "home".tr();
      case NavigationBarEnum.cart:
        return "cart".tr();
      case NavigationBarEnum.favorite:
        return "favorite".tr();
      case NavigationBarEnum.profile:
        return "profile".tr();
    }
  }

  IconData icon() {
    switch (this) {
      case NavigationBarEnum.home:
        return Icons.home_outlined;
      case NavigationBarEnum.cart:
        return Icons.shopping_cart_outlined;
      case NavigationBarEnum.favorite:
        return Icons.favorite_border_outlined;
      case NavigationBarEnum.profile:
        return Icons.person_2_outlined;
    }
  }
}
