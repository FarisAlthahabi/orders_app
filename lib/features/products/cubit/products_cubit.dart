import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/features/products/repo/products_repo.dart';

part 'states/products_state.dart';

part 'states/add_favorite_state.dart';

part 'states/general_products_state.dart';

@injectable
class ProductsCubit extends Cubit<GeneralProductsState> {
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  final ProductsRepo productsRepo;

  List<ProductModel> products = [];

  Future<void> getProducts(int storeId) async {
    emit(ProductsLoading());
    try {
      products = await productsRepo.getProducts(storeId);

      if (products.isEmpty) {
        emit(ProductsEmpty("There is no products"));
      } else {
        emit(ProductsSuccess(products));
      }
    } catch (e) {
      emit(ProductsFail(e.toString()));
    }
  }

  Future<void> getSearchedProducts(int storeId, String input) async {
    emit(ProductsLoading());
    try {
      products = await productsRepo.getSearchedProducts(storeId, input);

      if (products.isEmpty) {
        emit(ProductsEmpty("There is no products"));
      } else {
        emit(ProductsSuccess(products));
      }
    } catch (e) {
      if (e.toString().contains("could not be found")) {
        emit(ProductsEmpty(e.toString()));
      } else {
        emit(ProductsFail(e.toString()));
      }
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
