import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:orders_app/features/products/cubit/products_cubit.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';
import 'package:orders_app/global/widgets/product_tile.dart';

abstract class ProductsViewCallBacks {
  void onSearchChanged(String value);

  void onSearchSubmitted(String value);

  void onProductTap();

  void onMainAction();

  void onAddToFavorite(ProductModel product, bool isFavorite);

  void onCancelTap();
}

@RoutePage()
class ProductsView extends StatelessWidget {
  const ProductsView({
    super.key,
    required this.storeName,
  });

  final String storeName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: ProductsPage(storeName: storeName),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key,
    required this.storeName,
  });

  final String storeName;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    implements ProductsViewCallBacks {
  late final AppManagerCubit appManagerCubit = context.read();
  late final ProductsCubit productsCubit = context.read();

  final searchFocusNode = FocusNode();

  bool isCollecting = false;

  @override
  void initState() {
    productsCubit.getProducts();
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  void onSearchChanged(String value) {
    // TODO: implement onSearchChanged
  }

  @override
  void onSearchSubmitted(String value) {
    // TODO: implement onSearchSubmitted
  }

  @override
  void onProductTap() {
    // TODO: implement onStoreTap
  }

  @override
  void onAddToFavorite(ProductModel product, bool isFavorite) {
    if (isFavorite) {
      productsCubit.addFavorite(product, isFavorite);
    } else {
      productsCubit.removeFavorite(product, isFavorite);
    }
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
            Column(
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
                    buildWhen: (previous, current) => current is ProductsState,
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return CircularProgressIndicator();
                      } else if (state is ProductsSuccess) {
                        return ListView.separated(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductTile(
                              index: index,
                              product: product,
                              isCollecting: isCollecting,
                              onPressed: onProductTap,
                              onFavorite: onAddToFavorite,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                        );
                      } else if (state is ProductsEmpty) {
                        return Text(state.error);
                      } else if (state is ProductsFail) {
                        return Text(state.error);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
                SizedBox(height: 100),
              ],
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
                        width: 120,
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

