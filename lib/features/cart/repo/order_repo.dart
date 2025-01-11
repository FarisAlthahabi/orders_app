import 'package:injectable/injectable.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/features/products/model/order_item_model/order_item_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part 'order_repo_imp.dart';

abstract class OrderRepo {
  Future<List<OrderModel>> getOrders();

  Future<void> cancelOrder(int orderId);

  Future<void> orderProducts(List<OrderItemModel> orderItems);
}
