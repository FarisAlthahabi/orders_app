// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:orders_app/features/app_manager/view/app_manager_view.dart'
    as _i1;
import 'package:orders_app/features/cart/view/cart_view.dart' as _i2;
import 'package:orders_app/features/dashboard/view/dashboard_view.dart' as _i3;
import 'package:orders_app/features/favorite/view/favorite_view.dart' as _i4;
import 'package:orders_app/features/home/view/home_view.dart' as _i5;
import 'package:orders_app/features/intro/view/intro_view.dart' as _i7;
import 'package:orders_app/features/product_details/view/product_details_view.dart'
    as _i8;
import 'package:orders_app/features/products/view/products_view.dart' as _i9;
import 'package:orders_app/features/profile/view/profile_view.dart' as _i10;
import 'package:orders_app/features/select_role/view/intro_router.dart' as _i6;
import 'package:orders_app/features/select_role/view/select_role_view.dart'
    as _i11;
import 'package:orders_app/features/settings/view/settings_view.dart' as _i12;
import 'package:orders_app/features/sign_up/view/sign_up_view.dart' as _i13;
import 'package:orders_app/features/splash/view/splash_view.dart' as _i14;

/// generated route for
/// [_i1.AppManagerView]
class AppManagerRoute extends _i15.PageRouteInfo<void> {
  const AppManagerRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AppManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppManagerRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppManagerView();
    },
  );
}

/// generated route for
/// [_i2.CartView]
class CartRoute extends _i15.PageRouteInfo<void> {
  const CartRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.CartView();
    },
  );
}

/// generated route for
/// [_i3.DashboardView]
class DashboardRoute extends _i15.PageRouteInfo<void> {
  const DashboardRoute({List<_i15.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardView();
    },
  );
}

/// generated route for
/// [_i4.FavoriteView]
class FavoriteRoute extends _i15.PageRouteInfo<void> {
  const FavoriteRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.FavoriteView();
    },
  );
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeView();
    },
  );
}

/// generated route for
/// [_i6.IntroRoutePage]
class IntroRouter extends _i15.PageRouteInfo<void> {
  const IntroRouter({List<_i15.PageRouteInfo>? children})
      : super(
          IntroRouter.name,
          initialChildren: children,
        );

  static const String name = 'IntroRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.IntroRoutePage();
    },
  );
}

/// generated route for
/// [_i7.IntroView]
class IntroRoute extends _i15.PageRouteInfo<void> {
  const IntroRoute({List<_i15.PageRouteInfo>? children})
      : super(
          IntroRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.IntroView();
    },
  );
}

/// generated route for
/// [_i8.ProductDetailsView]
class ProductDetailsRoute extends _i15.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i16.Key? key,
    required int productId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            productId: productId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i8.ProductDetailsView(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
  });

  final _i16.Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i9.ProductsView]
class ProductsRoute extends _i15.PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    _i16.Key? key,
    required String storeName,
    required int storeId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            key: key,
            storeName: storeName,
            storeId: storeId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductsRouteArgs>();
      return _i9.ProductsView(
        key: args.key,
        storeName: args.storeName,
        storeId: args.storeId,
      );
    },
  );
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.key,
    required this.storeName,
    required this.storeId,
  });

  final _i16.Key? key;

  final String storeName;

  final int storeId;

  @override
  String toString() {
    return 'ProductsRouteArgs{key: $key, storeName: $storeName, storeId: $storeId}';
  }
}

/// generated route for
/// [_i10.ProfileView]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileView();
    },
  );
}

/// generated route for
/// [_i11.SelectRoleView]
class SelectRoleRoute extends _i15.PageRouteInfo<void> {
  const SelectRoleRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SelectRoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectRoleRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SelectRoleView();
    },
  );
}

/// generated route for
/// [_i12.SettingsView]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsView();
    },
  );
}

/// generated route for
/// [_i13.SignUpView]
class SignUpRoute extends _i15.PageRouteInfo<void> {
  const SignUpRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignUpView();
    },
  );
}

/// generated route for
/// [_i14.SplashView]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashView();
    },
  );
}
