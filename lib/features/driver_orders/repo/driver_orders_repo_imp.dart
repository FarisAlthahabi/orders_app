part of 'driver_orders_repo.dart';

@Injectable(as: DriverOrdersRepo)
class DriverOrdersRepoImp implements DriverOrdersRepo {
  final dioClient = DioClient();

  @override
  Future<OrderModel> changeOrderStatus(
    int orderId,
    UpdateOrderStatusModel updateOrderStatusModel,
  ) async {
    try {
      final response = await dioClient.post(
        "driver/order/updatestatus/$orderId",
        data: updateOrderStatusModel.toJson(),
      );
      final order = response.data["order"] as Map<String, dynamic>;
      return OrderModel.fromJson(order);
    } catch (e) {
      rethrow;
    }
  }
}
