import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class ProductDetailsTile extends StatelessWidget {
  const ProductDetailsTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppConstants.padding16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.22,
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: AppConstants.paddingL16,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColors.greyShade3,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}