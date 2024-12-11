import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'states/products_state.dart';

part 'states/add_favorite_state.dart';

part 'states/general_products_state.dart';

class ProductsCubit extends Cubit<GeneralProductsState> {
  ProductsCubit() : super(ProductsInitial());

  List<ProductModel> products = [];

  // List<ProductModel> get favoriteProducts =>
  //     products.where((product) => product.isFavorite).toList();

  // void setFavorite(bool isFavorite, int index) {
  //   products[index] = products[index].copyWith(isFavorite: isFavorite);
  // }

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      products = Products.localProducts;

      if (products.isEmpty) {
        emit(ProductsEmpty("There is no products"));
      } else {
        emit(ProductsSuccess(products));
      }
    } catch (e) {
      emit(ProductsFail(e.toString()));
    }
  }

  void addFavorite(ProductModel product, bool isFavorite) {
    final editedProduct = product.copyWith(isFavorite: isFavorite);
    products[product.id] = editedProduct;

    emit(AddFavoriteSuccess(editedProduct));
  }

  void removeFavorite(ProductModel product, bool isFavorite) {
    final editedProduct = product.copyWith(isFavorite: isFavorite);
    products[product.id] = editedProduct;

    emit(RemoveFavoriteSuccess(editedProduct));
  }
}
