import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({
    super.key,
    required this.onPressed,
    required this.name,
    required this.location,
    required this.image,
  });

  final ValueSetter<String> onPressed;
  final String image;
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: AppConstants.duration200ms,
      onPressed: () => onPressed(name),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: AppConstants.padding16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppConstants.borderRadius16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.production_quantity_limits,
                      size: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                  color: AppColors.blackShade2,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.22,
                ),
              ),
              SizedBox(height: 5),
              Text(
                location,
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
