import 'package:orders_app/features/app/orders_app.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/utils/run_app_with_reporting.dart';

void main() {
  runAppWithReporting(
    const OrdersApp(),
    preLaunch: configureDependencies,
  );
}

