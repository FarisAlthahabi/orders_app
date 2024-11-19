import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/router/router.dart';

class OrdersMaterialApp extends StatefulWidget {
  const OrdersMaterialApp({super.key});

  @override
  State<OrdersMaterialApp> createState() => _OrdersMaterialAppState();
}

class _OrdersMaterialAppState extends State<OrdersMaterialApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "app_name".tr(),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
