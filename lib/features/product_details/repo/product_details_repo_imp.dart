part of "product_details_repo.dart";

@Injectable(as: ProductDetailsRepo)
class ProductDetailsRepoImp implements ProductDetailsRepo {
  final dioClient = DioClient();

  @override
  Future<ProductModel> getProductDetails(int productId) async {
    try {
      final response = await dioClient.get(
        "product/show_one/$productId",
      );
      final productJson = response.data["data"] as Map<String, dynamic>;
      return ProductModel.fromJson(productJson);
    } catch (e) {
      rethrow;
    }
  }
}
