part of 'order_details_repo.dart';

@Injectable(as: OrderDetailsRepo)
class OrderDetailsRepoImp implements OrderDetailsRepo {
  final dioClient = DioClient();

  @override
  Future<List<OrderDetailsModel>> getOrderDetails(int orderId) async {
    final role = await get<UserRepo>().getKey(UserRepo.keys.userRole);
    try {
      final response = await dioClient.get(
        "$role/order/show_one/$orderId",
      );
      final orderProducts = response.data["order"] as List;
      return List.generate(
        orderProducts.length,
        (index) => OrderDetailsModel.fromJson(
            orderProducts[index] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProductQuantityInOrder(
    int orderId,
    int productId,
    int quantity,
  ) async {
    try {
      await dioClient.post(
          "customer/order/updateProductQuantityInOrder/$orderId/$productId",
          data: {
            "quantity": "$quantity",
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeProductFromOrder(int orderId, int productId) async {
    try {
      await dioClient
          .get("customer/order/removeProductFromOrder/$orderId/$productId");
    } catch (e) {
      rethrow;
    }
  }
}
