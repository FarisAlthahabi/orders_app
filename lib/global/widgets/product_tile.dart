import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/theme/components/shadows.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/app_image_widget.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({
    super.key,
    required this.onProduct,
    required this.isCollecting,
    required this.onLongPress,
    required this.index,
    required this.product,
    required this.addOrderitem,
    this.totalPrice,
    this.quantityOrdered,
  });
  final int index;
  final ProductModel product;
  final bool isCollecting;
  final ValueSetter<int> onProduct;
  final ValueSetter<int> onLongPress;
  final Function(int, int) addOrderitem;
  final int? totalPrice;
  final int? quantityOrdered;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int count = 0;

  void resetCount() {
    if (!widget.isCollecting) {
      count = 0;
    }
  }

  void increase() {
    setState(() {
      if (count < widget.product.quantity) {
        count++;
        widget.addOrderitem(widget.product.id, count);
      }
    });
  }

  void decrease() {
    setState(() {
      if (count != 0) {
        count--;
        widget.addOrderitem(widget.product.id, count);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.totalPrice;
    final quantityOrdered = widget.quantityOrdered;
    resetCount();

    return InkWell(
      onTap: () => widget.onProduct(widget.product.id),
      onLongPress: () => widget.onLongPress(widget.product.id),
      child: Container(
        padding: AppConstants.padding16,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppConstants.borderRadius16,
          boxShadow: AppShadows.shadow2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppImageWidget(
                  width: 80,
                  height: 80,
                  url: widget.product.image,
                  borderRadius: AppConstants.circularBorderRadius,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        color: AppColors.blackShade2,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        height: 1.22,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text.rich(
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.22,
                      ),
                      TextSpan(
                        text: widget.product.quantity.toString(),
                        children: [
                          TextSpan(
                            style: TextStyle(fontSize: 15),
                            text: " ${"available".tr()}",
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text.rich(
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.22,
                      ),
                      TextSpan(
                        text: widget.product.price.toString(),
                        children: [
                          TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            text: " ${"sp".tr()}",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                if (widget.isCollecting)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Bounce(
                        duration: AppConstants.duration200ms,
                        onPressed: increase,
                        child: Container(
                          padding: AppConstants.padding4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor.withOpacity(0.2),
                          ),
                          child: Assets.images.add.svg(width: 30, height: 30),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        count.toString(),
                        style: TextStyle(
                          color: AppColors.greyShade3,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Bounce(
                        duration: AppConstants.duration200ms,
                        onPressed: decrease,
                        child: Container(
                          padding: AppConstants.padding4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteShade2,
                          ),
                          child: Assets.images.minus.svg(width: 30, height: 30),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (totalPrice != null && quantityOrdered != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                    thickness: 0.5,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "total_price".tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        totalPrice.toString(),
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "quantity_ordered".tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        quantityOrdered.toString(),
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              )
          ],
        ),
      ),
    );
  }
}
