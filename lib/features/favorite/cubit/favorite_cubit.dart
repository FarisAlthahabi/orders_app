import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/favorite/repo/favorite_repo.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'states/favorite_state.dart';

part 'states/add_to_favorite_state.dart';

part 'states/remove_from_favorites_state.dart';

part 'states/general_favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<GeneralFavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());

  final FavoriteRepo favoriteRepo;

  List<ProductModel> localProducts = [];

  List<ProductModel> favoriteProducts = [];

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final products = await favoriteRepo.getFavoriteProducts();
      favoriteProducts = products;
      if (products.isEmpty) {
        emit(FavoriteEmpty("there_is_no_favorites_yet".tr()));
      } else {
        emit(
          FavoriteSuccess(products),
        );
      }
    } catch (e) {
      emit(FavoriteFail(e.toString()));
    }
  }

  Future<void> addToFavorites(int productId) async {
    emit(AddToFavoriteLoading());
    try {
      await favoriteRepo.addToFavorites(productId);

      emit(AddToFavoriteSuccess(
        "product_added_to_favorites".tr(),
      ));
    } catch (e) {
      emit(AddToFavoriteFail(e.toString()));
    }
  }

  Future<void> removeFromFavorites(int productId) async {
    emit(RemoveFromFavoritesLoading());
    try {
      await favoriteRepo.removeFromFavorites(productId);

      emit(RemoveFromFavoritesSuccess("product_removed_from_favorites".tr()));
      favoriteProducts.removeWhere(
        (product) => product.id == productId,
      );
      if (favoriteProducts.isEmpty) {
        emit(FavoriteEmpty("there_is_no_favorites_yet".tr()));
      } else {
        emit(FavoriteSuccess(favoriteProducts));
      }
      
    } catch (e) {
      emit(RemoveFromFavoritesFail(e.toString()));
    }
  }

  void addFavorite(ProductModel product) {
    localProducts.add(product);
    emit(
      FavoriteSuccess(localProducts),
    );
  }

  void removeFavorite(ProductModel product) {
    localProducts.remove(product);
    if (localProducts.isEmpty) {
      emit(FavoriteEmpty("There is no favorite products"));
    } else {
      emit(
        FavoriteSuccess(localProducts),
      );
    }
  }
}
