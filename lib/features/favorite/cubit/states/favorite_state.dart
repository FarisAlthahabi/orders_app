part of '../favorite_cubit.dart';

@immutable
class FavoriteState extends GeneralFavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<ProductModel> products;

  FavoriteSuccess(this.products);
}

final class FavoriteEmpty extends FavoriteState {
  final String message;

  FavoriteEmpty(this.message);
}
