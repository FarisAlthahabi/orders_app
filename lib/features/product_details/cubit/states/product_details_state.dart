part of '../product_details_cubit.dart';

@immutable
class ProductDetailsState extends GeneralProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsSuccess(this.product);
}

final class ProductDetailsFail extends ProductDetailsState {
  final String message;

  ProductDetailsFail(this.message);
}
