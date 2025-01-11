import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_app/features/product_details/cubit/product_details_cubit.dart';
import 'package:orders_app/features/product_details/view/widgets/product_details_tile.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';
import 'package:orders_app/global/widgets/main_error_widget.dart';
import 'package:orders_app/global/widgets/rectangular_image_widget.dart';

class TitleAndValue {
  final String title;
  final String value;

  TitleAndValue(this.title, this.value);
}

abstract class ProductDetailsViewCallbacks {
  void onTryAgainTap();

  Future<void> onRefresh();
}

@RoutePage()
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return ProductDetailsPage(productId: productId);
  }
}

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    implements ProductDetailsViewCallbacks {
  late final ProductDetailsCubit productDetailsCubit = context.read();

  @override
  void initState() {
    super.initState();
    productDetailsCubit.getProductDetails(widget.productId);
  }

  @override
  Future<void> onRefresh() async {
    productDetailsCubit.getProductDetails(widget.productId);
  }

  @override
  void onTryAgainTap() {
    productDetailsCubit.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: AppConstants.padding16,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                BlocBuilder<ProductDetailsCubit, GeneralProductDetailsState>(
                  builder: (context, state) {
                    if (state is ProductDetailsLoading) {
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
                    } else if (state is ProductDetailsSuccess) {
                      final product = state.product;
                      final productDetailsInfo = [
                        TitleAndValue("product_name".tr(), product.name),
                        TitleAndValue("available_quantity".tr(),
                            product.quantity.toString()),
                        TitleAndValue("description".tr(),
                            product.description ?? "no_description".tr()),
                        TitleAndValue("price".tr(), product.price.toString()),
                      ];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RectangularImageWidget(
                            fit: BoxFit.cover,
                            url: product.image,
                            width: double.maxFinite,
                            height: 250,
                          ),
                          SizedBox(height: 30),
                          ...productDetailsInfo.map(
                            (productDetail) => Column(
                              children: [
                                ProductDetailsTile(
                                  title: productDetail.title,
                                  value: productDetail.value,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    } else if (state is ProductDetailsFail) {
                      return MainErrorWidget(
                        height: MediaQuery.sizeOf(context).height / 3,
                        message: state.message,
                        onTap: onTryAgainTap,
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
