import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

void mainShowBottomSheet(
  BuildContext context,
   {
    Duration? duration,
  required Widget widget,
}) {
  showMaterialModalBottomSheet(
    context: context,
    duration: duration,
    bounce: true,    
    shape: const OutlineInputBorder(
      borderRadius: AppConstants.borderRadiusTop
    ),
    backgroundColor: AppColors.blackShade3,
    builder: (context) => widget,
  );
}