import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    super.key,
    required this.message,
    this.onTap,
    this.height,
  });

  final String message;
  final VoidCallback? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: height),
          Center(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5),
          if (onTap != null)
            Center(
              child: Bounce(
                duration: AppConstants.duration200ms,
                onPressed: onTap,
                child: Text(
                  "try_again".tr(),
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
