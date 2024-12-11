import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class MainBottomSheet extends StatelessWidget {
  const MainBottomSheet({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.padding16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
                height: 1.22,
              ),
            ),
          ),
          SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
