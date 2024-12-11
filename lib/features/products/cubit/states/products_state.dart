part of '../products_cubit.dart';

@immutable
class ProductsState extends GeneralProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;

  ProductsSuccess(this.products);
}

class ProductsEmpty extends ProductsState {
  final String error;

  ProductsEmpty(this.error);
}

class ProductsFail extends ProductsState {
  final String error;

  ProductsFail(this.error);
}
