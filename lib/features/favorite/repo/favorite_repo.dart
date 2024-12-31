import 'package:injectable/injectable.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part "favorite_repo_imp.dart";

abstract class FavoriteRepo {
  Future<List<ProductModel>> getFavoriteProducts();

  Future<void> addToFavorites(int productId);

  Future<void> removeFromFavorites(int productId);
}
