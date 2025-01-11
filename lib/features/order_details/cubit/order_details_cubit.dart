import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/order_details/model/order_details_model/order_details_model.dart';
import 'package:orders_app/features/order_details/repo/order_details_repo.dart';

part 'states/order_details_state.dart';

part 'states/update_product_quantity_in_order_state.dart';

part 'states/remove_product_from_order_state.dart';

part 'states/general_order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<GeneralOrderDetailsState> {
  OrderDetailsCubit(this.orderDetailsRepo) : super(OrderDetailsInitial());

  final OrderDetailsRepo orderDetailsRepo;

  List<OrderDetailsModel> orderDetails = [];

  int? quantityOrdered;

  void setQuantityOrdered(String quantityOrdered) {
    this.quantityOrdered = int.tryParse(quantityOrdered);
  }

  Future<void> getOrderDetails(int orderId) async {
    emit(OrderDetailsLoading());
    try {
      final orderDetails = await orderDetailsRepo.getOrderDetails(orderId);
      this.orderDetails = orderDetails;

      if (orderDetails.isEmpty) {
        emit(OrderDetailsEmpty("no_products".tr()));
      } else {
        emit(OrderDetailsSuccess(orderDetails));
      }
    } catch (e) {
      emit(OrderDetailsFail(e.toString()));
    }
  }

  Future<void> updateProductQuantityInOrder(
    int orderId,
    int productId,
  ) async {
    final quantityOrdered = this.quantityOrdered;
    if (quantityOrdered == null || quantityOrdered.toString().isEmpty) {
      emit(UpdateProductQuantityInOrderFail("Quantity can't be empty"));
      return;
    }
    emit(UpdateProductQuantityInOrderLoading());
    try {
      await orderDetailsRepo.updateProductQuantityInOrder(
        orderId,
        productId,
        quantityOrdered,
      );
      int indexOfUpdetedProduct = orderDetails.indexWhere(
        (orderDetail) => orderDetail.product.id == productId,
      );

      final availableQuantity =
          orderDetails[indexOfUpdetedProduct].product.quantity;
      final diffOldAndNewQuantity =
          quantityOrdered - orderDetails[indexOfUpdetedProduct].quantityOrdered;
      final newAvailableQuantity = availableQuantity - diffOldAndNewQuantity;

      orderDetails[indexOfUpdetedProduct] =
          orderDetails[indexOfUpdetedProduct].copyWith(
        product: orderDetails[indexOfUpdetedProduct]
            .product
            .copyWith(quantity: newAvailableQuantity),
        quantityOrdered: quantityOrdered,
        totalPrice: (quantityOrdered *
                orderDetails[indexOfUpdetedProduct].product.price)
            .toInt(),
      );

      this.quantityOrdered = null;

      emit(OrderDetailsSuccess(orderDetails));
      emit(UpdateProductQuantityInOrderSuccess("order_updated".tr()));
    } catch (e) {
      emit(UpdateProductQuantityInOrderFail(e.toString()));
    }
  }

  Future<void> removeProductFromOrder(
    int orderId,
    int productId,
  ) async {
    emit(RemoveProductFromOrderLoading());
    try {
      await orderDetailsRepo.removeProductFromOrder(orderId, productId);
      orderDetails.removeWhere(
        (orderDetail) => orderDetail.product.id == productId,
      );

      emit(RemoveProductFromOrderSuccess("product_removed_from_order".tr()));

      if (orderDetails.isEmpty) {
        emit(OrderDetailsEmpty("no_products".tr()));
      } else {
        emit(OrderDetailsSuccess(orderDetails));
      }
    } catch (e) {
      emit(RemoveProductFromOrderFail(e.toString()));
    }
  }
}
