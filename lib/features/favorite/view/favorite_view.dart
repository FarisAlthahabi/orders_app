import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/cart/cubit/orders_cubit.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

abstract class FavoriteViewCallBacks {
  void onProduct(int productId);

  Future<void> onRefresh();

  void onProductLongPress(int productId);

  void onRemoveFromFavorites(int productId);

  void addOrderItem(int productId, int count);

  void onMainAction();

  void onCancelTap();

  void onTryAgainTap();
}

@RoutePage()
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritePage();
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    implements FavoriteViewCallBacks {
  late final FavoriteCubit favoriteCubit = context.read();
  late final OrdersCubit ordersCubit = context.read();

  bool isCollecting = false;

  bool isProductsSuccess = false;

  @override
  void initState() {
    favoriteCubit.getFavorites();
    super.initState();
  }

  @override
  void onProduct(int productId) {
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
            onPressed: () => onRemoveFromFavorites(productId),
            child: Row(
              children: [
                Text(
                  "remove_from_favorites".tr(),
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
                    if (state is RemoveFromFavoritesSuccess) {
                      MainSnackBar.showSuccessMessage(
                        context,
                        state.message,
                      );
                      context.maybePop();
                    } else if (state is RemoveFromFavoritesFail) {
                      MainSnackBar.showErrorMessage(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    Widget child = Icon(
                      Icons.favorite,
                      color: AppColors.grey,
                    );
                    if (state is RemoveFromFavoritesLoading) {
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
  void addOrderItem(int productId, int count) {
    ordersCubit.addOrderItem(productId, count);
  }

  @override
  void onMainAction() {
    if (isCollecting) {
      ordersCubit.orderProducts(false);
    }
    setState(() {
      isCollecting = !isCollecting;
    });
  }

  @override
  void onCancelTap() {
    setState(() {
      isCollecting = false;
    });
  }

  @override
  void onRemoveFromFavorites(int productId) {
    favoriteCubit.removeFromFavorites(productId);
  }

  @override
  Future<void> onRefresh() async {
    favoriteCubit.getFavorites();
  }

  @override
  void onTryAgainTap() {
    favoriteCubit.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppManagerCubit, AppManagerState>(
          listener: (context, state) {
            if (state is FavoriteAdded) {
              favoriteCubit.addFavorite(state.product);
            } else if (state is FavoriteRemoved) {
              favoriteCubit.removeFavorite(state.product);
            }
          },
        ),
        BlocListener<FavoriteCubit, GeneralFavoriteState>(
          listener: (context, state) {
            if (state is FavoriteSuccess) {
              setState(() {
                isProductsSuccess = true;
              });
            } else if (state is FavoriteFail || state is FavoriteEmpty) {
              setState(() {
                isProductsSuccess = false;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: AppConstants.padding16,
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: onRefresh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "favorite_products".tr(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        height: 1.22,
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<FavoriteCubit, GeneralFavoriteState>(
                      buildWhen: (previous, current) =>
                          current is FavoriteState,
                      builder: (context, state) {
                        if (state is FavoriteLoading) {
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
                        } else if (state is FavoriteSuccess) {
                          return Expanded(
                            child: ListView.separated(
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return Column(
                                  children: [
                                    ProductTile(
                                      index: index,
                                      product: product,
                                      isCollecting: isCollecting,
                                      onProduct: onProduct,
                                      onLongPress: onProductLongPress,
                                      addOrderitem: addOrderItem,
                                    ),
                                    if (index == state.products.length - 1)
                                      SizedBox(height: 100),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                            ),
                          );
                        } else if (state is FavoriteEmpty) {
                          return MainErrorWidget(
                            message: state.message,
                            isEmpty: true,
                            onTap: onTryAgainTap,
                          );
                        } else if (state is FavoriteFail) {
                          return MainErrorWidget(
                            message: state.message,
                            onTap: onTryAgainTap,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (isProductsSuccess)
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: AppConstants.paddingB16,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(),
                        ),
                        if (isCollecting)
                          MainButton(
                            height: 70,
                            width: 130,
                            onPressed: onCancelTap,
                            text: "cancel".tr(),
                            textColor: AppColors.mainColor,
                            buttonColor: AppColors.white,
                            border: Border.all(
                                color: AppColors.mainColor, width: 1.5),
                          ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 6,
                          child: BlocConsumer<OrdersCubit, GeneralOrdersState>(
                            listener: (context, state) {
                              if (state is CreateOrderSuccess &&
                                  !state.isProductsPage) {
                                MainSnackBar.showSuccessMessage(
                                    context, state.message);
                              } else if (state is CreateOrderFail &&
                                  !state.isProductsPage) {
                                MainSnackBar.showErrorMessage(
                                    context, state.message);
                              }
                            },
                            builder: (context, state) {
                              Widget? child;
                              var onTap = onMainAction;
                              if (state is CreateOrderLoading) {
                                child = LoadingIndicator();
                                onTap = () {};
                              }
                              return MainButton(
                                height: 70,
                                onPressed: onTap,
                                text: isCollecting
                                    ? "order".tr()
                                    : "collect_products".tr(),
                                child: child,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
