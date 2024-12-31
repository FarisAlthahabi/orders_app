import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

abstract class FavoriteViewCallBacks {
  void onProduct(int productId);

  Future<void> onRefresh();

  void onProductLongPress(int productId);

  void onRemoveFromFavorites(int productId);

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
    return BlocListener<AppManagerCubit, AppManagerState>(
      listener: (context, state) {
        if (state is FavoriteAdded) {
          favoriteCubit.addFavorite(state.product);
        } else if (state is FavoriteRemoved) {
          favoriteCubit.removeFavorite(state.product);
        }
      },
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
                    SizedBox(height: 30),
                    Expanded(
                      child: BlocBuilder<FavoriteCubit, GeneralFavoriteState>(
                        buildWhen: (previous, current) =>
                            current is FavoriteState,
                        builder: (context, state) {
                          if (state is FavoriteLoading) {
                            return LoadingIndicator(
                              color: AppColors.black,
                            );
                          } else if (state is FavoriteSuccess) {
                            return ListView.separated(
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return ProductTile(
                                  index: index,
                                  product: product,
                                  isCollecting: false,
                                  onProduct: onProduct,
                                  onLongPress: onProductLongPress,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                            );
                          } else if (state is FavoriteEmpty) {
                            return MainErrorWidget(message: state.message);
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
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
