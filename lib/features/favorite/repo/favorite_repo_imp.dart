part of 'favorite_repo.dart';

@Injectable(as: FavoriteRepo)
class FavoriteRepoImp implements FavoriteRepo {
  final dioClient = DioClient();

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final response = await dioClient.get(
        "Favourite/getFavorites",
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
  Future<void> addToFavorites(int productId) async {
    try {
      await dioClient.post("Favourite/add/$productId");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromFavorites(int productId)async {
     try {
      await dioClient.get("Favourite/removeFromFavorites/$productId");
    } catch (e) {
      rethrow;
    }
  }
}
