import 'package:injectable/injectable.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part "product_details_repo_imp.dart";

abstract class ProductDetailsRepo {
  Future<ProductModel> getProductDetails(int productId);
}
