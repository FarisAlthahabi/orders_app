part of 'order_repo.dart';

@Injectable(as: OrderRepo)
class OrderRepoImp implements OrderRepo {
  final dioClient = DioClient();

  @override
  Future<List<OrderModel>> getOrders({required bool isAll}) async {
    final role = await get<UserRepo>().getKey(UserRepo.keys.userRole);
    String orderQuantity = isAll ? "show_all" : "showDriveOrder";
    try {
      final response = await dioClient.get(
        "$role/order/$orderQuantity",
      );
      final ordersJson = response.data["data"] as List;
      return List.generate(
        ordersJson.length,
        (index) =>
            OrderModel.fromJson(ordersJson[index] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelOrder(int orderId) async {
    try {
      await dioClient.get(
        "customer/order/cancelOrder/$orderId",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> orderProducts(List<OrderItemModel> orderItems) async {
    try {
      await dioClient.post("customer/order/store", data: {
        "products": List.generate(
          orderItems.length,
          (index) => orderItems[index].toJson(),
        )
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderModel> addToDriverOrders(int orderId) async {
    try {
      final response = await dioClient.get(
        "driver/order/updateOrder/$orderId",
      );
      final order = response.data["order"] as Map<String, dynamic>;
      return OrderModel.fromJson(order);
      
    } catch (e) {
      rethrow;
    }
  }
}
