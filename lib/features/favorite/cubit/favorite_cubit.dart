import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'states/favorite_state.dart';

part 'states/general_favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<ProductModel> products = [];

  void getFavorites() {
    if (products.isEmpty) {
      emit(FavoriteEmpty("There is no favorites yet"));
    } else {
      emit(FavoriteSuccess(products));
    }
  }

  void addFavorite(ProductModel product) {
    products.add(product);
    emit(FavoriteSuccess(products));
  }

  void removeFavorite(ProductModel product) {
    products.remove(product);
    if (products.isEmpty) {
      emit(FavoriteEmpty("There is no favorite products"));
    } else {
      emit(FavoriteSuccess(products));
    }

    final x = product.copyWith(isFavorite: false);
    
  }
}
