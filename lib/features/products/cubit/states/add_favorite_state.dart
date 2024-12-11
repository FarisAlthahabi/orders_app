part of '../products_cubit.dart';

@immutable
class AddFavoriteState extends GeneralProductsState {}

class AddFavoriteInitial extends AddFavoriteState {}

class AddFavoriteSuccess extends AddFavoriteState {
  final ProductModel product;

  AddFavoriteSuccess(this.product);
}

class RemoveFavoriteSuccess extends AddFavoriteState {
  final ProductModel product;

  RemoveFavoriteSuccess(this.product);
}
