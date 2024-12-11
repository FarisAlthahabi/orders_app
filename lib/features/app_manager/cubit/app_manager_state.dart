part of 'app_manager_cubit.dart';

@immutable
sealed class AppManagerState {}

final class AppManagerInitial extends AppManagerState {}

final class FavoriteAdded extends AppManagerState {
  final ProductModel product;

  FavoriteAdded(this.product);
}

final class FavoriteRemoved extends AppManagerState {
  final ProductModel product;

  FavoriteRemoved(this.product);
}
