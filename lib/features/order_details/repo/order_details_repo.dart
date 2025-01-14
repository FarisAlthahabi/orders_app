import 'package:injectable/injectable.dart';
import 'package:orders_app/features/order_details/model/order_details_model/order_details_model.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/dio/dio_client.dart';
import 'package:orders_app/global/repos/user_repo.dart';

part 'order_details_repo_imp.dart';

abstract class OrderDetailsRepo {
  Future<List<OrderDetailsModel>> getOrderDetails(int orderId);

  Future<void> updateProductQuantityInOrder(
    int orderId,
    int productId,
    int quantity,
  );

  Future<void> removeProductFromOrder(
    int orderId,
    int productId,
  );
}
