import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/widgets/main_bottom_sheet.dart';

class ChooseImageSourceWidget extends StatelessWidget {
  const ChooseImageSourceWidget({
    super.key,
    required this.pickGalleryImage,
    required this.pickCameraImage,
  });

  final VoidCallback pickGalleryImage;
  final VoidCallback pickCameraImage;

  @override
  Widget build(BuildContext context) {
    return MainBottomSheet(
      title: "choose_image_source".tr(),
      children: [
        TextButton(
          onPressed: pickGalleryImage,
          child: Row(
            children: [
              Text(
                "gallery".tr(),
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  height: 1.22,
                ),
              ),
              SizedBox(width: 18),
              Icon(
                Icons.collections,
                color: AppColors.grey,
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: pickCameraImage,
          child: Row(
            children: [
              Text(
                "camera".tr(),
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  height: 1.22,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.camera_alt_outlined,
                color: AppColors.grey,
              )
            ],
          ),
        ),
      ],
    );
  }
}
