import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/cart/cubit/orders_cubit.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/order_tile.dart';

abstract class CartViewCallbacks {
  void onOrderLongPress(int orderId);

  void onOrderTap(int orderId);

  void onCancelOrder(int orderId);

  Future<void> onRefresh();

  void onTryAgainTap();
}

@RoutePage()
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartPage();
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements CartViewCallbacks {
  late final OrdersCubit ordersCubit = context.read();

  @override
  void initState() {
    super.initState();
    ordersCubit.getOrders();
  }

  @override
  void onCancelOrder(int orderId) {
    ordersCubit.cancelOrder(orderId);
  }

  @override
  void onOrderLongPress(int orderId) {
    mainShowBottomSheet(
      context,
      widget: MainBottomSheet(
        title: "orders_options".tr(),
        children: [
          TextButton(
            onPressed: () => onCancelOrder(orderId),
            child: Row(
              children: [
                Text(
                  "cancel_order".tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.22,
                  ),
                ),
                SizedBox(width: 18),
                BlocConsumer<OrdersCubit, GeneralOrdersState>(
                  listener: (context, state) {
                    if (state is CancelOrderSuccess) {
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                      context.maybePop();
                    } else if (state is CancelOrderFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    Widget child = Icon(
                      Icons.delete,
                      color: AppColors.grey,
                    );
                    if (state is CancelOrderLoading) {
                      child = LoadingIndicator();
                    }
                    return child;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onOrderTap(int orderId) {
    context.router.push(OrderDetailsRoute(orderId: orderId));
  }

  @override
  Future<void> onRefresh() async {
    ordersCubit.getOrders();
  }

  @override
  void onTryAgainTap() {
    ordersCubit.getOrders();
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
                BlocBuilder<OrdersCubit, GeneralOrdersState>(
                  buildWhen: (previous, current) => current is OrdersState,
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 3.8),
                        child: LoadingIndicator(
                          color: AppColors.black,
                        ),
                      );
                    } else if (state is OrdersSuccess) {
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];

                          return OrderTile(
                            order: order,
                            onOrderTap: onOrderTap,
                            onOrderLongPress: onOrderLongPress,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                      );
                    } else if (state is OrdersEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height / 4.6),
                        child: MainErrorWidget(
                          message: state.message,
                          isEmpty: true,
                          onTap: onTryAgainTap,
                        ),
                      );
                    } else if (state is OrdersFail) {
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
