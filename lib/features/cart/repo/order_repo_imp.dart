part of 'order_repo.dart';

@Injectable(as: OrderRepo)
class OrderRepoImp implements OrderRepo {
  final dioClient = DioClient();

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await dioClient.get(
        "Customer/order/show_all",
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
        "Customer/order/cancelOrder/$orderId",
      );
    } catch (e) {
      rethrow;
    }
  }

   @override
  Future<void> orderProducts(List<OrderItemModel> orderItems) async {
    try {
      await dioClient.post("Customer/order/store", data: {
        "products": List.generate(
          orderItems.length,
          (index) => orderItems[index].toJson(),
        )
      });
    } catch (e) {
      rethrow;
    }
  }
}
