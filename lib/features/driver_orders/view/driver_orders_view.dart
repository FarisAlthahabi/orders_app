import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/features/driver_orders/cubit/driver_order_cubit.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';
import 'package:orders_app/global/widgets/order_tile.dart';

abstract class DriverOrdersViewCallBacks {
  void onOrderTap(int orderId);

  void onOrderLongPress(OrderModel order);

  void onUpdateOrderStatusTap(int orderId);

  void onApplyUpdateOrderStatusTap(int orderId);

  void onCancelUpdateOrderStatusTap(BuildContext context);

  void onStatusChanged(String status);

  void onStatusSubmitted(String status);

  void onPaymentChanged(String payment);

  void onPaymentSubmitted(String payment);

  Future<void> onRefresh();

  void onTryAgainTap();
}

@RoutePage()
class DriverOrdersView extends StatelessWidget {
  const DriverOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DriverOrdersPage();
  }
}

class DriverOrdersPage extends StatefulWidget {
  const DriverOrdersPage({super.key});

  @override
  State<DriverOrdersPage> createState() => _DriverOrdersPageState();
}

class _DriverOrdersPageState extends State<DriverOrdersPage>
    implements DriverOrdersViewCallBacks {
  late final DriverOrderCubit driverOrderCubit = context.read();
  final statusFocusNode = FocusNode();
  final paymentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    driverOrderCubit.getOrders(isAll: false);
  }

  @override
  void onOrderTap(int orderId) {
    context.router.push(OrderDetailsRoute(orderId: orderId));
  }

  @override
  void onApplyUpdateOrderStatusTap(int orderId) {
    driverOrderCubit.changeOrderStatus(orderId);
  }

  @override
  void onCancelUpdateOrderStatusTap(BuildContext context) {
    context.router.popForced();
  }

   @override
  void onPaymentChanged(String payment) {
    driverOrderCubit.setPayment(payment);
  }

  @override
  void onPaymentSubmitted(String payment) {
    paymentFocusNode.unfocus();
  }

  @override
  void onStatusChanged(String status) {
    driverOrderCubit.setStatus(status);
  }

  @override
  void onStatusSubmitted(String status) {
    paymentFocusNode.requestFocus();
  }

  @override
  void onUpdateOrderStatusTap(int orderId) {
    context.router.popForced();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "change_order_status".tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  height: 1.22,
                ),
              ),
              SizedBox(height: 16),
              MainTextField(
                padding: AppConstants.padding10,
                onChanged: onStatusChanged,
                onSubmitted: onStatusSubmitted,
                focusNode: statusFocusNode,
                hintText: "status".tr(),
              ),
              SizedBox(height: 16),
              MainTextField(
                padding: AppConstants.padding10,
                onChanged: onPaymentChanged,
                onSubmitted: onPaymentSubmitted,
                focusNode: paymentFocusNode,
                hintText: "payment".tr(),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.white),
                side: WidgetStatePropertyAll(
                  BorderSide(color: AppColors.mainColor, width: 0.5),
                ),
              ),
              onPressed: () => onCancelUpdateOrderStatusTap(context),
              child: Text(
                "cancel".tr(),
                style: TextStyle(color: AppColors.black),
              ),
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
                ),
                onPressed: () => onApplyUpdateOrderStatusTap(orderId),
                child:
                    BlocConsumer<DriverOrderCubit, GeneralDriverOrderState>(
                  listener: (context, state) {
                    if (state is UpdateDriverOrderStatusSuccess) {
                      context.router.popForced();
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                    } else if (state is UpdateDriverOrderStatusFail) {
                      MainSnackBar.showErrorMessage(context, state.message);
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is UpdateDriverOrderStatusState,
                  builder: (context, state) {
                    Widget child = Text(
                      "apply".tr(),
                      style: TextStyle(color: AppColors.white),
                    );
                    if (state is UpdateDriverOrderStatusLoading) {
                      child = LoadingIndicator(
                        width: 50,
                        size: 30,
                      );
                    }
                    return child;
                  },
                )),
          ],
        );
      },
    );
  }

  @override
  void onOrderLongPress(OrderModel order) {
    mainShowBottomSheet(
      context,
      widget: MainBottomSheet(
        title: "orders_options".tr(),
        children: [
          TextButton(
            onPressed: () => onUpdateOrderStatusTap(order.id),
            child: Row(
              children: [
                Text(
                  "change_order_status".tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.22,
                  ),
                ),
                SizedBox(width: 18),
                Icon(
                  Icons.track_changes,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onRefresh() async {
    driverOrderCubit.getOrders(isAll: false);
  }

  @override
  void onTryAgainTap() {
    driverOrderCubit.getOrders(isAll: false);
  }

  @override
  void dispose() {
    statusFocusNode.dispose();
    paymentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.padding16,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "my_orders".tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.22,
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<DriverOrderCubit, GeneralDriverOrderState>(
                  buildWhen: (previous, current) => current is DriverOrderState,
                  builder: (context, state) {
                    if (state is DriverOrderLoading) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 3.8),
                        child: LoadingIndicator(
                          color: AppColors.black,
                        ),
                      );
                    } else if (state is DriverOrderSuccess) {
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];

                          return OrderTile(
                              order: order,
                              index: index,
                              onOrderTap: onOrderTap,
                              onOrderLongPress: onOrderLongPress);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                      );
                    } else if (state is DriverOrderEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 4.6),
                        child: MainErrorWidget(
                          message: state.message,
                          isEmpty: true,
                          onTap: onTryAgainTap,
                        ),
                      );
                    } else if (state is DriverOrderFail) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 4.6),
                        child: MainErrorWidget(
                          message: state.error,
                          onTap: onTryAgainTap,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
