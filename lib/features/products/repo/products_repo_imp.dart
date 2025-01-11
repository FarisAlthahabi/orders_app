part of 'products_repo.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImp implements ProductsRepo {
  final dioClient = DioClient();

  @override
  Future<List<ProductModel>> getProducts(int storeId) async {
    try {
      final response = await dioClient.get(
        "product/show_all/$storeId",
      );
      final products = response.data["data"] as List;
      return List.generate(
        products.length,
        (index) =>
            ProductModel.fromJson(products[index] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getSearchedProducts(
    int storeId,
    String input,
  ) async {
    try {
      final response = await dioClient
          .get("product/search_name/$storeId", data: {"search": input});
      final products = response.data["data"] as List;
      return List.generate(
        products.length,
        (index) =>
            ProductModel.fromJson(products[index] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
