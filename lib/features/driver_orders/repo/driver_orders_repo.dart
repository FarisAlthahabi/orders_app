import 'package:injectable/injectable.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/features/driver_orders/model/update_order_status_model/update_order_status_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part 'driver_orders_repo_imp.dart';

abstract class DriverOrdersRepo {
  Future<OrderModel> changeOrderStatus(
    int orderId,
    UpdateOrderStatusModel updateOrderStatusModel,
  );
}
