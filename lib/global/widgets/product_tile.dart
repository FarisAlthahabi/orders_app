import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/features/products/model/product_model/product_model.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/theme/components/shadows.dart';
import 'package:orders_app/global/utils/constants.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({
    super.key,
    required this.onPressed,
    required this.isCollecting,
    required this.onFavorite,
    required this.index,
    required this.product,
  });
  final int index;
  final ProductModel product;
  final bool isCollecting;
  final VoidCallback onPressed;
  final Function(ProductModel, bool) onFavorite;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int count = 0;
  late bool isFavorite = widget.product.isFavorite;

  void resetCount() {
    if (!widget.isCollecting) {
      count = 0;
    }
  }

  void onFavoriteTap() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavorite(widget.product, isFavorite);
  }

  void increase() {
    setState(() {
      if (count < widget.product.availableAmount) {
        count++;
      }
    });
  }

  void decrease() {
    setState(() {
      if (count != 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    resetCount();

    return Badge(
      backgroundColor: AppColors.white,
      isLabelVisible: !widget.isCollecting,
      padding: AppConstants.padding0,
      offset: Offset(-40, 25),
      label: Bounce(
        duration: AppConstants.duration200ms,
        onPressed: onFavoriteTap,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 30,
        ),
      ),
      child: Bounce(
        duration: AppConstants.duration200ms,
        onPressed: widget.onPressed,
        child: Container(
          padding: AppConstants.padding16,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppConstants.borderRadius16,
            boxShadow: AppShadows.shadow2,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.shadow3,
                  ),
                  child: FlutterLogo(),
                ),
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
                      text: widget.product.availableAmount.toString(),
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
        ),
      ),
    );
  }
}
