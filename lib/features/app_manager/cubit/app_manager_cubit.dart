import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'app_manager_state.dart';

@injectable
class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  void addFavorite(ProductModel product) {
    emit(FavoriteAdded(product));
  }

  void removeFavorite(ProductModel product) {
    emit(FavoriteRemoved(product));
  }
}
