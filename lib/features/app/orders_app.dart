import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app/orders_material_app.dart';
import 'package:orders_app/features/driver_orders/cubit/driver_order_cubit.dart';
import 'package:orders_app/features/order_details/cubit/order_details_cubit.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/localization/cubit/localization_cubit.dart';
import 'package:orders_app/global/repos/user_repo.dart';

class OrdersApp extends StatelessWidget {
  const OrdersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/locales',
      fallbackLocale: const Locale('en'),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => get<UserRepo>(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => get<LocalizationCubit>(),
            ),
            BlocProvider(
              create: (context) => get<OrderDetailsCubit>(),
            ),
            BlocProvider(
              create: (context) => get<DriverOrderCubit>(),
            ),
          ],
          child: const OrdersMaterialApp(),
        ),
      ),
    );
  }
}
