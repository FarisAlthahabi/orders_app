part of '../favorite_cubit.dart';

@immutable
class RemoveFromFavoritesState extends GeneralFavoriteState {}

final class RemoveFromFavoritesInitial extends RemoveFromFavoritesState {}

final class RemoveFromFavoritesLoading extends RemoveFromFavoritesState {}

final class RemoveFromFavoritesSuccess extends RemoveFromFavoritesState {
  final String message;

  RemoveFromFavoritesSuccess(this.message);
}

final class RemoveFromFavoritesFail extends RemoveFromFavoritesState {
  final String message;

  RemoveFromFavoritesFail(this.message);
}