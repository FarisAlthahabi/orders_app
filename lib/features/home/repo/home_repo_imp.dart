part of "home_repo.dart";

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final dioClient = DioClient();
  
  @override
  Future<List<StoreModel>> getStores()async {
    try {
      final response = await dioClient.get(
        "shop/show_all",
      );
      final stores = response.data["data"] as List;
      return List.generate(
        stores.length,
        (index) =>
            StoreModel.fromJson(stores[index] as Map<String, dynamic>),
      );
      
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<List<StoreModel>> getSearchedStores(String input) async {
    try {
      final response = await dioClient.get(
        "shop/search_name",
        data: {"search" : input}
      );
      final stores = response.data["data"] as List;
      return List.generate(
        stores.length,
        (index) =>
            StoreModel.fromJson(stores[index] as Map<String, dynamic>),
      );
      
    } catch (e) {
      rethrow;
    }
  }
}
