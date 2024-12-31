part of '../favorite_cubit.dart';

@immutable
class AddToFavoriteState extends GeneralFavoriteState {}

final class AddToFavoriteInitial extends AddToFavoriteState {}

final class AddToFavoriteLoading extends AddToFavoriteState {}

final class AddToFavoriteSuccess extends AddToFavoriteState {
  final String message;

  AddToFavoriteSuccess(this.message);
}

final class AddToFavoriteFail extends AddToFavoriteState {
  final String message;

  AddToFavoriteFail(this.message);
}
