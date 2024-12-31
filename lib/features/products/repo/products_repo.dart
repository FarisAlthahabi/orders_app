import 'package:injectable/injectable.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part 'products_repo_imp.dart';

abstract class ProductsRepo {
  Future<List<ProductModel>> getProducts(int storeId);

  Future<List<ProductModel>> getSearchedProducts(int storeId, String input);
}
