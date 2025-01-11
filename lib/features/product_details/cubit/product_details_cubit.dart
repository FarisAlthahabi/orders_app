import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/product_details/repo/product_details_repo.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'states/product_details_state.dart';

part 'states/general_product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<GeneralProductDetailsState> {
  ProductDetailsCubit(this.productDetailsRepo) : super(ProductDetailsInitial());

  final ProductDetailsRepo productDetailsRepo;

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productDetailsRepo.getProductDetails(productId);
      
      emit(ProductDetailsSuccess(product));
    } on Exception catch (e) {
      emit(ProductDetailsFail(e.toString()));
    }
  }
}
