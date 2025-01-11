import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/features/order_details/cubit/order_details_cubit.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

abstract class OrderDetailsViewCallBacks {
  void onTryAgainTap();

  Future<void> onRefresh();

  void onProductTap(int productId);

  void onProductLongPress(int productId);

  void onAddToFavorite(int productId);

  void onUpdateProductQuantityTap(int productId);

  void onApplyUpdateProductQuantityTap(int productId);

  void onRemoveFromOrderTap(int productId);

  void onCancelUpdateProductQuantityTap(BuildContext context);

  void onQuantityChanged(String quantity);

  void onQuantitySubmitted(String quantity);
}

@RoutePage()
class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return OrderDetailsPage(orderId: orderId);
  }
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage>
    implements OrderDetailsViewCallBacks {
  late final OrderDetailsCubit orderDetailsCubit = context.read();
  late final FavoriteCubit favoriteCubit = context.read();

  final quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    orderDetailsCubit.getOrderDetails(widget.orderId);
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  void onProductTap(int productId) {
    context.router.push(ProductDetailsRoute(productId: productId));
  }

  @override
  void onProductLongPress(int productId) {
    mainShowBottomSheet(
      context,
      widget: MainBottomSheet(
        title: "product_options".tr(),
        children: [
          TextButton(
            onPressed: () => onAddToFavorite(productId),
            child: Row(
              children: [
                Text(
                  "add_to_favorites".tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.22,
                  ),
                ),
                SizedBox(width: 18),
                BlocConsumer<FavoriteCubit, GeneralFavoriteState>(
                  listener: (context, state) {
                    if (state is AddToFavoriteSuccess) {
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                      context.maybePop();
                    } else if (state is AddToFavoriteFail) {
                      MainSnackBar.showErrorMessage(context, state.message);
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AddToFavoriteState,
                  builder: (context, state) {
                    Widget child = Icon(
                      Icons.favorite,
                      color: AppColors.grey,
                    );
                    if (state is AddToFavoriteLoading) {
                      child = LoadingIndicator();
                    }
                    return child;
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => onUpdateProductQuantityTap(productId),
            child: Row(
              children: [
                Text(
                  "change_quantity_ordered".tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.22,
                  ),
                ),
                SizedBox(width: 18),
                Icon(
                  Icons.production_quantity_limits_outlined,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => onRemoveFromOrderTap(productId),
            child: Row(
              children: [
                Text(
                  "remove_from_order".tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.22,
                  ),
                ),
                SizedBox(width: 18),
                BlocConsumer<OrderDetailsCubit, GeneralOrderDetailsState>(
                  listener: (context, state) {
                    if (state is RemoveProductFromOrderSuccess) {
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                      context.maybePop();
                    } else if (state is RemoveProductFromOrderFail) {
                      MainSnackBar.showErrorMessage(context, state.message);
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is RemoveProductFromOrderState,
                  builder: (context, state) {
                    Widget child = Icon(
                      Icons.delete,
                      color: AppColors.grey,
                    );
                    if (state is RemoveProductFromOrderLoading) {
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
  void onCancelUpdateProductQuantityTap(BuildContext context) {
    context.router.popForced();
  }

  @override
  void onApplyUpdateProductQuantityTap(int productId) {
    orderDetailsCubit.updateProductQuantityInOrder(widget.orderId, productId);
  }

  @override
  void onRemoveFromOrderTap(int productId) {
    orderDetailsCubit.removeProductFromOrder(widget.orderId, productId);
  }

  @override
  void onUpdateProductQuantityTap(int productId) {
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
                "change_quantity_ordered".tr(),
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
                onChanged: onQuantityChanged,
                onSubmitted: onQuantitySubmitted,
                focusNode: quantityFocusNode,
                hintText: "quantity".tr(),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )
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
              onPressed: () => onCancelUpdateProductQuantityTap(context),
              child: Text(
                "cancel".tr(),
                style: TextStyle(color: AppColors.black),
              ),
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
                ),
                onPressed: () => onApplyUpdateProductQuantityTap(productId),
                child:
                    BlocConsumer<OrderDetailsCubit, GeneralOrderDetailsState>(
                  listener: (context, state) {
                    if (state is UpdateProductQuantityInOrderSuccess) {
                      context.router.popForced();
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                    } else if (state is UpdateProductQuantityInOrderFail) {
                      MainSnackBar.showErrorMessage(context, state.message);
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is UpdateProductQuantityInOrderState,
                  builder: (context, state) {
                    Widget child = Text(
                      "apply".tr(),
                      style: TextStyle(color: AppColors.white),
                    );
                    if (state is UpdateProductQuantityInOrderLoading) {
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
  void onQuantityChanged(String quantity) {
    orderDetailsCubit.setQuantityOrdered(quantity);
  }

  @override
  void onQuantitySubmitted(String quantity) {
    quantityFocusNode.unfocus();
  }

  @override
  void onAddToFavorite(
    int productId,
  ) {
    favoriteCubit.addToFavorites(productId);
  }

  @override
  Future<void> onRefresh() async {
    orderDetailsCubit.getOrderDetails(widget.orderId);
  }

  @override
  void onTryAgainTap() {
    orderDetailsCubit.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: AppConstants.padding16,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "ordered_products".tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.22,
                ),
              ),
              SizedBox(height: 30),
              BlocBuilder<OrderDetailsCubit, GeneralOrderDetailsState>(
                buildWhen: (previous, current) => current is OrderDetailsState,
                builder: (context, state) {
                  if (state is OrderDetailsLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 3,
                        ),
                        LoadingIndicator(
                          color: AppColors.black,
                        ),
                      ],
                    );
                  } else if (state is OrderDetailsSuccess) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.orderDetails.length,
                        itemBuilder: (context, index) {
                          final productOrdered = state.orderDetails[index];
                          return ProductTile(
                            index: index,
                            product: productOrdered.product,
                            isCollecting: false,
                            addOrderitem: (p0, p1) {},
                            onProduct: onProductTap,
                            onLongPress: onProductLongPress,
                            totalPrice: productOrdered.totalPrice,
                            quantityOrdered: productOrdered.quantityOrdered,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                      ),
                    );
                  } else if (state is OrderDetailsEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height / 3),
                      child: MainErrorWidget(
                        message: state.error,
                        isEmpty: true,
                        onTap: onTryAgainTap,
                      ),
                    );
                  } else if (state is OrderDetailsFail) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height / 3),
                      child: MainErrorWidget(
                        message: state.error,
                        onTap: onTryAgainTap,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
