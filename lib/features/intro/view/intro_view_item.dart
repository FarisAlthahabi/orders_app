import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';

class IntroViewItem extends StatelessWidget {
  const IntroViewItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(image)),
        SizedBox(height: 40),
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 30,
            height: 1.36,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 20,
            height: 1.46,
            fontWeight: FontWeight.w400,
          ),
          strutStyle: StrutStyle(
            height: 1.5
          ),
        ),
      ],
    );
  }
}
