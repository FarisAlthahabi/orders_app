import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/favorite/cubit/favorite_cubit.dart';
import 'package:orders_app/features/products/cubit/products_cubit.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/main_show_bottom_sheet.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

abstract class ProductsViewCallBacks {
  void onSearchChanged(String value);

  void onSearchSubmitted(String value);

  void onProductTap(int productId);

  void onProductLongPress(int productId);

  void onMainAction();

  void onAddToFavorite(int productId);

  void onCancelTap();

  Future<void> onRefresh();

  void onTryAgainTap();
}

@RoutePage()
class ProductsView extends StatelessWidget {
  const ProductsView({
    super.key,
    required this.storeName,
    required this.storeId,
  });

  final String storeName;
  final int storeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<ProductsCubit>(),
        ),
      ],
      child: ProductsPage(
        storeName: storeName,
        storeId: storeId,
      ),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key,
    required this.storeName,
    required this.storeId,
  });

  final String storeName;
  final int storeId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    implements ProductsViewCallBacks {
  late final AppManagerCubit appManagerCubit = context.read();
  late final ProductsCubit productsCubit = context.read();
  late final FavoriteCubit favoriteCubit = context.read();

  final searchFocusNode = FocusNode();

  bool isCollecting = false;

  @override
  void initState() {
    productsCubit.getProducts(widget.storeId);
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  void onSearchChanged(String value) {
    if (value.isEmpty) {
      productsCubit.getProducts(widget.storeId);
    }
  }

  @override
  void onSearchSubmitted(String value) {
    productsCubit.getSearchedProducts(widget.storeId, value);
  }

  @override
  void onProductTap(int productId) {
    context.router.push(ProductDetailsRoute(productId: productId));
  }

  @override
  Future<void> onRefresh() async {
    productsCubit.getProducts(widget.storeId);
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
        ],
      ),
    );
  }

  @override
  void onTryAgainTap() {
    productsCubit.getProducts(widget.storeId);
  }

  @override
  void onAddToFavorite(
    int productId,
  ) {
    favoriteCubit.addToFavorites(productId);
  }

  @override
  void onCancelTap() {
    setState(() {
      isCollecting = false;
    });
  }

  @override
  void onMainAction() {
    setState(() {
      isCollecting = !isCollecting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(
          widget.storeName,
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            height: 1.22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppConstants.padding16,
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: onRefresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "available_products".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      height: 1.22,
                    ),
                  ),
                  SizedBox(height: 20),
                  MainTextField(
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: "search".tr(),
                    onChanged: onSearchChanged,
                    onSubmitted: onSearchSubmitted,
                    focusNode: searchFocusNode,
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: BlocConsumer<ProductsCubit, GeneralProductsState>(
                      listener: (context, state) {
                        if (state is AddFavoriteSuccess) {
                          appManagerCubit.addFavorite(state.product);
                        } else if (state is RemoveFavoriteSuccess) {
                          appManagerCubit.removeFavorite(state.product);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is ProductsState,
                      builder: (context, state) {
                        if (state is ProductsLoading) {
                          return LoadingIndicator(
                            color: AppColors.black,
                          );
                        } else if (state is ProductsSuccess) {
                          return ListView.separated(
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductTile(
                                index: index,
                                product: product,
                                isCollecting: isCollecting,
                                onProduct: onProductTap,
                                onLongPress: onProductLongPress,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                          );
                        } else if (state is ProductsEmpty) {
                          return MainErrorWidget(message: state.error);
                        } else if (state is ProductsFail) {
                          return MainErrorWidget(
                            message: state.error,
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
                        border:
                            Border.all(color: AppColors.mainColor, width: 1.5),
                      ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: MainButton(
                        height: 70,
                        onPressed: onMainAction,
                        text: isCollecting
                            ? "order".tr()
                            : "collect_products".tr(),
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
    );
  }
}
