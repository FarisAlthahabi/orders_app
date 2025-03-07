import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/features/cart/repo/order_repo.dart';
import 'package:orders_app/features/products/model/order_item_model/order_item_model.dart';

part 'states/orders_state.dart';

part 'states/create_order_state.dart';

part 'states/cancel_order_state.dart';

part 'states/add_to_driver_orders_state.dart';

part 'states/general_orders_state.dart';

@injectable
class OrdersCubit extends Cubit<GeneralOrdersState> {
  OrdersCubit(this.orderRepo) : super(OrdersInitial());

  final OrderRepo orderRepo;

  List<OrderModel> localCustomerOrders = [];

  List<OrderModel> localDriverOrders = [];

  List<OrderItemModel> orderItems = [];

  void addOrderItem(int productId, int quantity) {
    int existingIndex =
        orderItems.indexWhere((item) => item.productId == productId);

    if (existingIndex != -1) {
      if (quantity == 0) {
        orderItems.removeAt(existingIndex);
      } else {
        orderItems[existingIndex] = orderItems[existingIndex].copyWith(
          productId: productId,
          quantity: quantity,
        );
      }
    } else {
      if (quantity > 0) {
        OrderItemModel orderItem = OrderItemModel();
        orderItem = orderItem.copyWith(
          productId: productId,
          quantity: quantity,
        );
        orderItems.add(orderItem);
      }
    }
  }

  Future<void> getOrders({required bool isAll}) async {
    emit(OrdersLoading());
    try {
      final orders = await orderRepo.getOrders(isAll: isAll);
      if (isAll) {
        localCustomerOrders = orders;
      } else {
        localDriverOrders = orders;
      }

      if (orders.isEmpty) {
        emit(OrdersEmpty("there_is_no_orders".tr()));
      } else {
        emit(OrdersSuccess(orders));
      }
    } catch (e) {
      if (e.toString().contains("could not be found")) {
        emit(OrdersEmpty("there_is_no_orders".tr()));
      } else {
        emit(OrdersFail(e.toString()));
      }
    }
  }

  Future<void> cancelOrder(int orderId) async {
    emit(CancelOrderLoading());
    try {
      await orderRepo.cancelOrder(orderId);
      localCustomerOrders.removeWhere(
        (order) => order.id == orderId,
      );

      emit(CancelOrderSuccess("order_canceled".tr()));

      if (localCustomerOrders.isEmpty) {
        emit(OrdersEmpty("there_is_no_orders".tr()));
      } else {
        emit(OrdersSuccess(localCustomerOrders));
      }
    } catch (e) {
      emit(CancelOrderFail(e.toString()));
    }
  }

  Future<void> orderProducts(bool isProductsPage) async {
    if (orderItems.isEmpty) {
      emit(CreateOrderFail("did_not_collect_any_product".tr(), isProductsPage));
      return;
    }
    emit(CreateOrderLoading(isProductsPage));
    try {
      await orderRepo.orderProducts(orderItems);
      emit(CreateOrderSuccess("order_created".tr(), isProductsPage));
      orderItems = [];
    } catch (e) {
      emit(CreateOrderFail(e.toString(), isProductsPage));
      orderItems = [];
    }
  }

  Future<void> addToDriverOrders(int orderId) async {
    emit(AddToDriverOrdersLoading());
    try {
      await orderRepo.addToDriverOrders(orderId);

      emit(AddToDriverOrdersSuccess("order_added_to_your_orders".tr()));

      if (localCustomerOrders.isEmpty) {
        emit(OrdersEmpty("there_is_no_orders".tr()));
      } else {
        emit(OrdersSuccess(localCustomerOrders));
      }
    } catch (e) {
      emit(AddToDriverOrdersFail(e.toString()));
    }
  }
}
