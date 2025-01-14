import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/features/cart/repo/order_repo.dart';
import 'package:orders_app/features/driver_orders/model/update_order_status_model/update_order_status_model.dart';
import 'package:orders_app/features/driver_orders/repo/driver_orders_repo.dart';

part 'states/driver_order_state.dart';

part 'states/update_driver_order_status_state.dart';

part 'states/general_driver_order_state.dart';

@injectable
class DriverOrderCubit extends Cubit<GeneralDriverOrderState> {
  DriverOrderCubit(this.orderRepo, this.driverOrdersRepo)
      : super(DriverOrderInitial());

  final OrderRepo orderRepo;
  final DriverOrdersRepo driverOrdersRepo;

  List<OrderModel> driverOrders = [];

  UpdateOrderStatusModel updateOrderStatusModel = UpdateOrderStatusModel();

  void setStatus(String status) {
    updateOrderStatusModel = updateOrderStatusModel.copyWith(
      status: status,
    );
  }

  void setPayment(String payment) {
    updateOrderStatusModel = updateOrderStatusModel.copyWith(
      payment: payment,
    );
  }

  Future<void> getOrders({required bool isAll}) async {
    emit(DriverOrderLoading());
    try {
      final orders = await orderRepo.getOrders(isAll: isAll);
      driverOrders = orders;

      if (orders.isEmpty) {
        emit(DriverOrderEmpty("there_is_no_orders".tr()));
      } else {
        emit(DriverOrderSuccess(orders));
      }
    } catch (e) {
      emit(DriverOrderFail(e.toString()));
    }
  }

  Future<void> changeOrderStatus(int orderId) async {
    emit(UpdateDriverOrderStatusLoading());
    try {
      await driverOrdersRepo.changeOrderStatus(
        orderId,
        updateOrderStatusModel,
      );

      final indexOfDriverOrder = driverOrders.indexWhere(
        (element) => element.id == orderId,
      );
      driverOrders[indexOfDriverOrder] =
          driverOrders[indexOfDriverOrder].copyWith(
        status: updateOrderStatusModel.status,
        payment: updateOrderStatusModel.payment,
      );

      emit(DriverOrderSuccess(driverOrders));
      emit(UpdateDriverOrderStatusSuccess("order_updated".tr()));
    } catch (e) {
      emit(UpdateDriverOrderStatusFail(e.toString()));
    }
  }
}
